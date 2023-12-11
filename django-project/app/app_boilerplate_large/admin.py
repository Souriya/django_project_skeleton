# coding=utf-8
from django.contrib import admin

from .models.model_set1 import *



# Register your models here.

'''
# snipet

@admin.register(ModelName)
class ModelNameAdmin(admin.ModelAdmin):
    list_display = ['field1', 'field2',]
'''