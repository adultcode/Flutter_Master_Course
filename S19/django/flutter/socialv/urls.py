from django.urls import path,include
from rest_framework.routers import DefaultRouter

from socialv import views

router = DefaultRouter()
router.register('posts',views.PostsViewSet,basename='posts')
router.register('friend',views.MyPost,basename='friend')
router.register('users',views.UsersViewSet,basename='users')
router.register('follow',views.FollowViewSet,basename='follow')
router.register('user-page',views.UserPageViewSet,basename='user-page')
router.register('like',views.LikePost,basename='like')
router.register('comment',views.SendCommentViewSet,basename='comment')
router.register('send-post',views.SendPostViewSet,basename='send-post')
router.register('edit-profile',views.EditProfileViewSet,basename='edit-profile')
router.register('get-comment',views.GetCommentViewSet,basename='get-comment')
urlpatterns =[
    # path('hello-view/', views.HelloApiView.as_view()),
    # path('OrderCreate/', views.OrderCreate.as_view()),
    path('login/', views.UserLoginApiView.as_view()),
    path('signup/', views.UserSignupAPI.as_view()),
    path('',include(router.urls)),
    # path('callback', views.all_blogs, name='callback'),

]