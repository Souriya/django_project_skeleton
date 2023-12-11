# coding=utf-8
# django libs
from django.urls import path, include
from .views.view_set1 import *

# 3rd party libs
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
#router.register('', views.ViewSet)

urlpatterns = [
    path('api/', include(router.urls)),
]