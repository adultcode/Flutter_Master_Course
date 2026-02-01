from django.db import models
from rest_framework.response import Response

# Create your models here.
import json
import uuid
from datetime import datetime
from django.http import JsonResponse
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.models import BaseUserManager
from django.contrib.auth.models import AbstractBaseUser

from django.contrib.auth import get_user_model
# Create your models here.

# User = get_user_model()


class UserProfileManager(BaseUserManager):
    """Manager for user profiles"""

    def create_user(self, email, name,avatar,bio, password=None):
        """Create a new user profile"""
        if not email:
            raise ValueError('Users must have an email address')

        email = self.normalize_email(email)
        user = self.model(email=email, name=name,avatar=avatar,bio=bio)

        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, email, name, password):
        """Create and save a new superuser with given details"""
        user = self.create_user(email=email, name=name,bio='',avatar='', password=password)

        user.is_superuser = True
        user.is_staff = True
        user.save(using=self._db)

        return user


class UserProfile(AbstractBaseUser, PermissionsMixin):
    """Database model for users in the system"""
    email = models.EmailField(max_length=255,null='d', unique=True)
    name = models.CharField(max_length=255,default='z')
    bio = models.CharField(max_length=500,default="",blank=True, null=True)
    avatar = models.ImageField(upload_to='profile_images',default='avatar.jpg')
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = UserProfileManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name']

    def get_full_name(self):
        """Retrieve full name for user"""
        return self.name

    def get_short_name(self):
        """Retrieve short name of user"""
        return self.name

    def __str__(self):
        """Return string representation of user"""
        return self.email
#
class Post(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4)
    user = models.ForeignKey(UserProfile,on_delete=models.CASCADE,related_name='profiles')
    image = models.ImageField(upload_to='post_images',blank=True, null=True)
    liked = models.ManyToManyField(UserProfile, blank=True)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    @property
    def like_count(self):
      #  return "ss"

        return self.liked.all().count()

    @property
    def user_set(self):
        data = UserProfile.objects.get(pk=self.user_id)
        if(data.avatar):
            img = data.avatar.url
        else: img = 'empty'
        user_json = {
            "id": data.id,
            "bio": data.bio,
            "email": data.email,
            "avatar": img,
            "name": data.name
        }
        return user_json


class PostComment(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE,related_name='users')
    postid = models.CharField(max_length=700)
    created_at = models.DateTimeField(default=datetime.now)
    content = models.CharField(max_length=700)
    def __str__(self):
        return self.content

    @property
    def user_set(self):
        data = UserProfile.objects.get(pk=self.user_id)
        if (data.avatar):
            img = data.avatar.url
        else:
            img = 'empty'
        user_json = {
            "id": data.id,
            "bio": data.bio,
            "email": data.email,
            "avatar": img,
            "name": data.name
        }
        return user_json

#
class Test(models.Model):
    title = models.CharField(max_length=200)

class Friends(models.Model):
    user =models.ForeignKey(UserProfile,on_delete=models.CASCADE)
    following = models.ForeignKey(UserProfile,on_delete=models.CASCADE,related_name='follow')

# class FollowList(models.Model):
#     user =models.ForeignKey(UserProfile,on_delete=models.CASCADE)
#     following = models.ForeignKey(UserProfile,on_delete=models.CASCADE,related_name='following')

class FollowerCount(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    count = models.IntegerField(default=0)
class FollowingCount(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE,related_name='profile')
    count = models.IntegerField(default=0)