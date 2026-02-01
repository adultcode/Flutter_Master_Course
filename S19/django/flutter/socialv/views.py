from django.contrib.auth.decorators import login_required
from django.shortcuts import render

# Create your views here.
import json
from base64 import b64encode
from datetime import datetime
from json import JSONDecoder
import requests
from django.core.files.uploadedfile import InMemoryUploadedFile
from django.db.models.fields.files import ImageFieldFile
from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework import viewsets
from socialv import serializermodel
from socialv import models
from rest_framework import filters
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.settings import api_settings
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from rest_framework.permissions import IsAuthenticated
from socialv import permissions
from rest_framework.authentication import TokenAuthentication
import base64
import io
from PIL import Image

from socialv.models import Friends
from socialv.serializermodel import PostSerializer, UserProfileSerializer, UserPageSerializer, CommentSerializer


class UserLoginApiView(ObtainAuthToken):
    renderer_classes = api_settings.DEFAULT_RENDERER_CLASSES

    def post(self, request, *args, **kwargs):

        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            #  'status': status.HTTP_200_OK,
            'name': user.name,
            'bio': user.bio,
            'avatar': user.avatar.url,
            'email': user.email
        })

    def encode_datetime(obj):
        """
        Extended encoder function that helps to serialize dates and images
        """
        if isinstance(obj, datetime.date):
            try:
                return obj.strftime('%Y-%m-%d')
            except ValueError as e:
                return ''

        if isinstance(obj, ImageFieldFile):
            try:
                return obj.path
            except ValueError as e:
                return ''

        raise TypeError(repr(obj) + " is not JSON serializable")


class UserSignupAPI(ObtainAuthToken):
    renderer_classes = api_settings.DEFAULT_RENDERER_CLASSES

    def post(self, request, *args, **kwargs):


        name = request.data['name']
        email = request.data['email']
        password = request.data['password']

        print("name: ",name)
        user_obj = models.UserProfile()
        user_obj.name = name
        user_obj.email = email
        user_obj.set_password(password)
        user_obj.save()
        token, created = Token.objects.get_or_create(user=user_obj)
        # with open(user.profile, 'rb') as img:
        #     profile_img = b64encode(img.read())
        #pr = user.profile
        return Response({
            'token': token.key,
            'name': user_obj.name,
            'bio': user_obj.bio,
            'avatar': user_obj.avatar.url,
            'email': user_obj.email
            #  'status': status.HTTP_200_OK,

        })

    def encode_datetime(obj):
        """
        Extended encoder function that helps to serialize dates and images
        """
        if isinstance(obj, datetime.date):
            try:
                return obj.strftime('%Y-%m-%d')
            except ValueError as e:
                return ''

        if isinstance(obj, ImageFieldFile):
            try:
                return obj.path
            except ValueError as e:
                return ''

        raise TypeError(repr(obj) + " is not JSON serializable")

class UsersViewSet(viewsets.ModelViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )
    def list(self, request, *args, **kwargs):
        data = UserProfileSerializer(models.UserProfile.objects.all(), many=True, context={'request': request})
        return JsonResponse({'users': data.data})


class PostsViewSet(viewsets.ModelViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )
    def list(self, request, *args, **kwargs):
        data = PostSerializer(models.Post.objects.all().order_by('-created_at'), many=True, context={'request': request})
        return JsonResponse({'posts': data.data})



class MyPost(viewsets.ModelViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )
    def list(self, request, *args, **kwargs):
        current_user = request.user
        user = models.UserProfile.objects.get(id=current_user.id)
        print("name ",user.name)
        following = models.Friends.objects.filter(user=user).values_list('following')
        print(following.count())
        data = PostSerializer(models.Post.objects.filter(user__in=following).order_by('-created_at'), many=True, context={'request': request})
        return JsonResponse({'posts': data.data})



class GetCommentViewSet(viewsets.ModelViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )
    def create(self, request, *args, **kwargs):
        post_id = request.data['postid']
        print(post_id)
        data = CommentSerializer(models.PostComment.objects.filter(postid=post_id), many=True, context={'request': request})
        return JsonResponse({'comments': data.data})



class SendPostViewSet(viewsets.ViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )


    def create(self, request, *args, **kwargs):
        post_img = request.data['img']
        post_content = request.data['content']
        current_user = request.user
        current_profile = models.UserProfile.objects.get(pk=current_user.id)
        try:
            new_post = models.Post()
            new_post.user = current_profile
            new_post.content = post_content
            if post_img !='null':
                decoded_img = self.decode_base64_file(post_img)
                new_post.image = decoded_img
            new_post.save()
            x = "done"
        except Exception as e:
            x = 'Fail'
        return JsonResponse({'status': x})

    def decode_base64_file(q, data):

        def get_file_extension(file_name, decoded_file):
            import imghdr

            extension = imghdr.what(file_name, decoded_file)
            extension = "jpg" if extension == "jpeg" else extension

            return extension

        from django.core.files.base import ContentFile
        import base64
        #import six
        import uuid

        # Check if this is a base64 string

            # Check if the base64 string is in the "data:" format
        if 'data:' in data and ';base64,' in data:

                # Break out the header from the base64 content
            header, data = data.split(';base64,')

            # Try to decode the file. Return validation error if it fails.
            try:
                decoded_file = base64.b64decode(data)
            except TypeError:
                TypeError('invalid_image')

            # Generate file name:
            file_name = str(uuid.uuid4())[:12]  # 12 characters are more than enough.
            # Get the file name extension:
            file_extension = get_file_extension(file_name, decoded_file)

            complete_file_name = "%s.%s" % (file_name, file_extension,)

            return ContentFile(decoded_file, name=complete_file_name)




class EditProfileViewSet(viewsets.ModelViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )
    def create(self, request, *args, **kwargs):
        user_img = request.data['img']
        user_bio = request.data['bio']
        user_name = request.data['name']
        current_user = request.user

        try:
            current_profile = models.UserProfile.objects.get(pk=current_user.id)
            if user_img != 'null':
                decoded_img = self.decode_base64_file(user_img)
                current_profile.avatar = decoded_img


            current_profile.bio = user_bio
            current_profile.name = user_name

            current_profile.save()
            x = {
                "name": current_profile.name,
                "bio": current_profile.bio,
                "img": current_profile.avatar.url
            }
            #x = "Profile Updated"
        except Exception as e:
            x = 'Fail'
        return JsonResponse({'status': x})

    def decode_base64_file(q, data):

        def get_file_extension(file_name, decoded_file):
            import imghdr

            extension = imghdr.what(file_name, decoded_file)
            extension = "jpg" if extension == "jpeg" else extension

            return extension

        from django.core.files.base import ContentFile
        import base64
        #import six
        import uuid

        # Check if this is a base64 string

            # Check if the base64 string is in the "data:" format
        if 'data:' in data and ';base64,' in data:

                # Break out the header from the base64 content
            header, data = data.split(';base64,')

            # Try to decode the file. Return validation error if it fails.
            try:
                decoded_file = base64.b64decode(data)
            except TypeError:
                TypeError('invalid_image')

            # Generate file name:
            file_name = str(uuid.uuid4())[:12]  # 12 characters are more than enough.
            # Get the file name extension:
            file_extension = get_file_extension(file_name, decoded_file)

            complete_file_name = "%s.%s" % (file_name, file_extension,)

            return ContentFile(decoded_file, name=complete_file_name)


class SendCommentViewSet(viewsets.ModelViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )
    def create(self, request, *args, **kwargs):
        post_id = request.data['postid']
        cm_message = request.data['comment']
        current_user = request.user
        current_profile = models.UserProfile.objects.get(pk=current_user.id)
        try:
            new_cm = models.PostComment()
            new_cm.user = current_profile
            new_cm.content = cm_message
            new_cm.postid = post_id
            new_cm.save()
            x = "done"
        except Exception as e:
            x = 'Fail'
        return JsonResponse({'status': x})


class LikePost(viewsets.ModelViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )

    def create(self, request, *args, **kwargs):
        print("list method")
        post_id = request.data['postid']
        print("post id: ",post_id)
        current_user = request.user
        current_profile = models.UserProfile.objects.get(pk=current_user.id)
        current_post = models.Post.objects.get(id=post_id)
        if current_profile in current_post.liked.all():
            #remove user from liked list
            current_post.liked.remove(current_profile)
            x = 'Unliked'
        else:
            current_post.liked.add(current_profile)
            x = 'liked'
        return JsonResponse({'status': x})


class FollowViewSet(viewsets.ViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )
    def create(self, request, *args, **kwargs):
        pk_sec_user = request.data['target_user']
        is_follow = request.data['isfollow'] # 0= not follow this user, 1= follow this user
        print("is_follow ",is_follow)
        sec_profile = models.UserProfile.objects.get(id=pk_sec_user)

        current_user = request.user


        try:
            if int(is_follow)==0:
                print("000")
                friend_data = models.Friends()
                friend_data.user = current_user
                friend_data.following = sec_profile
                friend_data.save()
                return JsonResponse({'status': "Followed"})
            else:
                print("111")
                friend_data = models.Friends.objects.get(user=current_user, following=sec_profile)
                print(friend_data.user.name)
                friend_data.delete()
                return JsonResponse({'status': "Unfollowed"})


        except Exception as e:
            print("Error: ",e)
            return JsonResponse({'status': "Error"})



class UserPageViewSet(viewsets.ModelViewSet):
    """Handles creating, reading and updating profile feed items"""
    authentication_classes = (TokenAuthentication,)

    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated
    )
    def list(self, request, *args, **kwargs):
        pk_sec_user = request.GET['target_user']
        data = UserPageSerializer(models.UserProfile.objects.filter(id=pk_sec_user), many=True, context={'request': request})
        return JsonResponse({'user': data.data})


