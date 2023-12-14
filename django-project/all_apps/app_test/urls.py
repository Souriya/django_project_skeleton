# coding=utf-8
# django libs
from django.urls import path, include
from . import views

# 3rd party libs
from rest_framework.routers import DefaultRouter

router = DefaultRouter()

urlpatterns = [
    path('hello/', views.hello, name='hello'),
    path('api/', include(router.urls)),
]

# when user go to path /app_test it will show api root page (endpoints list)
urlpatterns += router.urls
