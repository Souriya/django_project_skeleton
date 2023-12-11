# coding=utf-8
# django libs
from django.urls import path, include

# 3rd party libs
from rest_framework.routers import DefaultRouter

# from .views.view_set1 import *

router = DefaultRouter()

urlpatterns = [
    path('api/', include(router.urls)),
]
