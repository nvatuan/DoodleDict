import os
from django.conf import settings  
pred_b64_img = getattr(settings, "PREDICT_B64", None)

from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response

from Draw.models import getSampleGuess
import requests
import json
from googletrans import Translator

import base64
# Create your views here.

@api_view(['GET', 'POST'])
def drawApi(request):
    try:
        data = {}
        rawb64 = json.loads(request.body)["pic"].replace('\n', '')
        lbl = pred_b64_img(rawb64)
        data['word'] = {'en': lbl}
        data['img'] = [
            'https://previews.123rf.com/images/upixel123/upixel1231508/upixel123150800065/43848148-computer-sign-computer-plate-501-not-implemented.jpg',
        ]
        return Response(data)
    except Exception as e:
        # raise 
        print(e)
    data = getSampleGuess()
    return Response(data)

@api_view(['GET', 'POST'])
def drawExperimentApi(request):
    translator = Translator()
    data = getSampleGuess()
    # keyWord = data['word']['en']
    # data['word']['vi'] = translator.translate(keyWord, dest='vi').text
    # data['word']['ja'] = translator.translate(keyWord, dest='ja').text
    # data['word']['fr'] = translator.translate(keyWord, dest='fr').text
    # data['word']['ru'] = translator.translate(keyWord, dest='ru').text
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

