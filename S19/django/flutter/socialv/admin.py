from django.contrib import admin

# Register your models here.
from socialv.models import UserProfile,Post,PostComment,Friends,Test


admin.site.register(UserProfile)
admin.site.register(Post)
admin.site.register(PostComment)
admin.site.register(Friends)
admin.site.register(Test)

