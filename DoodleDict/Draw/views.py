import os
from django.conf import settings  

unsplash_key = getattr(settings, 'UNSPLASH_ACCESS_KEY', None)
unsplash_get_cnt = getattr(settings, 'UNSPLASH_GET_COUNT', 5)
unsplash_img_dim = getattr(settings, 'UNSPLASH_IMG_DIM', (1600,900))
pred_b64_img = getattr(settings, "PREDICT_B64", None)

from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response

from Draw.models import getSampleGuess
import requests
import json
from googletrans import Translator

import base64

import asyncio

async def retrieve_imgs(keyword):
    r = requests.get(
        'https://api.unsplash.com/search/photos?query={}'.format(keyword),
        headers = {
            'Accept-Version': 'v1',
            'Content-Type': 'application/json',
            'Authorization': 'Client-ID {}'.format(unsplash_key)
        }
    )
    imgs = []
    for i in range(unsplash_get_cnt):
        try:
            raw = r.json()['results'][i]['urls']['raw']
            raw += '&w={}&h={}&fit=crop'.format(*unsplash_img_dim)
            imgs.append(raw)
        except IndexError:
            break
    return imgs

# Create your views here.

@api_view(['GET', 'POST'])
def drawApi(request):
    try:
        data = {}
        rawb64 = json.loads(request.body)["pic"].replace('\n', '')
        lbl = pred_b64_img(rawb64)
        data['word'] = lbl

        try:
            data['img']  = asyncio.run(retrieve_imgs(lbl['en']))
        except Exception as e:
            raise e
            data['img'] = [
                'https://www.creativefabrica.com/wp-content/uploads/2019/12/23/404-error-flat-icon-vector-Graphics-1.jpg'
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

