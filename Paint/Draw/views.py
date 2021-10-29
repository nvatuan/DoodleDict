from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response

from Draw.models import getSampleGuess
import requests
import json
from googletrans import Translator
# Create your views here.

@api_view(['GET', 'POST'])
def drawApi(request):
    data = getSampleGuess()
    return Response(data)

@api_view(['GET', 'POST'])
def drawExperimentApi(request):
    data = getSampleGuess()
    return Response(data)

@api_view(['GET'])
def translateApi(request):
    keyWord = request.GET.get('keyWord', '')
    data = {
        'data':{
            'keyWord':keyWord,
            'translations':{
                'vi':'',
                'ja':'',
                'fr':'',
                'ru':''
            }
        }
    }
    translator = Translator()
    data['data']['translations']['vi'] = translator.translate(keyWord, dest='vi').text
    data['data']['translations']['ja'] = translator.translate(keyWord, dest='ja').text
    data['data']['translations']['fr'] = translator.translate(keyWord, dest='fr').text
    data['data']['translations']['ru'] = translator.translate(keyWord, dest='ru').text

    return Response(data)

@api_view(['GET'])
def randomImage(request):
    import requests
    r = requests.get('https://picsum.photos/400')
    data = {
        'url': r.url
    }
    return Response(data)
## -- 

