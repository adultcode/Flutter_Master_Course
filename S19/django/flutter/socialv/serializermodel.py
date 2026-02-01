from requests import Response
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers

from socialv import models
from socialv.models import Post, PostComment


class UserProfileSerializer(ModelSerializer):
    """Serializes a user profile object"""

    class Meta:
        model = models.UserProfile
        fields = ('id', 'bio','email','avatar','name', 'password')
        extra_kwargs = {
            'password': {
                'write_only': True,
                'style': {'input_type': 'password'}
            }
        }

    def create(self, validated_data):
        """Create and return a new user"""
        user = models.UserProfile.objects.create_user(
            email=validated_data['email'],
            name=validated_data['name'],
            bio=validated_data['bio'],
            avatar=validated_data['avatar'],
            password=validated_data['password']
        )

        return user


class UserPageSerializer(ModelSerializer):
    """Serializes profile feed items"""
    # is_Liked = serializers.SerializerMethodField()
    follower = serializers.SerializerMethodField()
    following = serializers.SerializerMethodField()
    post_count = serializers.SerializerMethodField()
    post = serializers.SerializerMethodField()
    isfollow = serializers.SerializerMethodField()


    def get_post_count(self, obj):
        try:
            print(obj.id)
            user = models.UserProfile.objects.filter(id=obj.id)
            posts = models.Post.objects.all().filter(user__in=user)


            x=posts.count()

        except Exception as e:
            print("Error: ",e)
            #print("no")
            x='no'
        return x


    # 1: you are follow this user, 0: not following this user
    def get_isfollow(self, obj):
        try:
            print(obj.id)
            target_user = models.UserProfile.objects.filter(id=obj.id)
            request = self.context.get('request')
            current_user = request.user
            current_userProfile = models.UserProfile.objects.filter(id=current_user.id)
            print("Current user: ",current_user.id)
            print("target user: ",target_user)
            following = models.Friends.objects.filter(user__in=current_userProfile).filter(following__in=target_user)

            #posts = models.Post.objects.get(user__in=user)

            x=following.count()

        except Exception as e:
            print("Error: ",e)
            #print("no")
            x='no'
        return x
    def get_post(self, obj):
        try:
            print(obj.id)
            user = models.UserProfile.objects.filter(id=obj.id)
            posts = models.Post.objects.all().filter(user__in=user)
            user_post = PostSerializer(posts,
                                       many=True,context={'request': self.context.get('request')})
            x = user_post.data
        except Exception as e:
            print("Error: ",e)
            #print("no")
            x='no'
        return x

    def get_following(self, obj):
        try:
            print(obj.id)
            user = models.UserProfile.objects.filter(id=obj.id)
            following = models.Friends.objects.filter(user__in=user)
            print("count",following.count())
            x= following.count()
        except Exception as e:
            print("Error: ",e)
            x='no'
        return x

    def get_follower(self, obj):
        try:
            print("get follower",obj.id)
            user = models.UserProfile.objects.filter(id=obj.id)
            followers = models.Friends.objects.filter(following__in=user)
            #x=v.count()
            print("count",followers.count())
            x= followers.count()
        except Exception as e:
            print("Error: ",e)
            #print("no")
            x='no'
        return x

    class Meta:
        model = models.UserProfile
        fields =('id','name','avatar','email','bio','follower','following','isfollow','post_count','post')


class CommentSerializer(ModelSerializer):
    """Serializes profile feed items"""


    class Meta:
        model = PostComment
        fields =('id','content','postid','user_set')


class PostSerializer(ModelSerializer):
    """Serializes profile feed items"""
    is_Liked = serializers.SerializerMethodField()
    comment_count = serializers.SerializerMethodField()
    test = serializers.SerializerMethodField()


    def get_test(self,obj):

        try:
            t = obj.user
            x = t.id

        except Exception as e:
            x = 'error'
        return x

    def get_comment_count(self, obj):
        try:
            v = models.PostComment.objects.filter(postid=obj.id)
            x=v.count()
        except Exception as e:
            print("Error: ",e)
            x='no'
        return x
    def get_is_Liked(self,obj):
        #  return "ss"
        request = self.context.get('request')
        current_user = request.user
        data = models.UserProfile.objects.get(pk=current_user.id)
        if data in obj.liked.all():
            temp = True
        else:
            temp = False
        return temp
    class Meta:
        model = Post
        #extra_fields = ('len_name')
        fields =('id','test','content','image','is_Liked','like_count','comment_count','user_set')

        def get_len_name(self, obj):
            print("get_it")
            return  "test"
