from django.contrib import admin

# Register your models here.
from chat.models import Todo

admin.site.register(Todo)