# coding=utf-8
from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader


def hello(request):
    template = loader.get_template('test-lao-font.html')
    return HttpResponse(template.render())
