import os
from django.conf import settings  

pred_b64_img = getattr(settings, "PREDICT_B64", None)

from django.shortcuts import render
from django.http import HttpRequest

from rest_framework.decorators import api_view
from rest_framework.response import Response

from Draw.models import getSampleGuess, Doodle, Label
from Image.models import Image
from Image.views import __searchImage

from googletrans import Translator
import requests
import json
import base64
import asyncio

import pygeoip
GEO_IP = pygeoip.GeoIP( getattr(settings, 'MAXMIND_DB', None) )

def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_REMOTE_ADDR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip

@api_view(['GET', 'POST'])
def drawApi(request):
    try:
        doodle = Doodle()

        ip = get_client_ip(request)
        print('Client IP:', ip)
        if ip:
            try:
                print('Client Geolocation:', GEO_IP.country_name_by_addr(ip), GEO_IP.country_code_by_addr(ip))
                doodle.country = GEO_IP.country_name_by_addr(ip)
                doodle.country_code = GEO_IP.country_code_by_addr(ip)
            except:
                print('Client Geolocation not available')
                pass

        data = {}
        rawb64 = json.loads(request.body)["pic"].replace('\n', '')
        doodle.base64 = rawb64

        lbl = pred_b64_img(rawb64)
        data['word'] = lbl

        try:
            label = Label.objects.get(word_en=lbl['en'])
            if not label.word:
                label.word = lbl
                label.save()
        except Label.DoesNotExist:
            label = Label.objects.create(word_en=lbl['en'], word=lbl)

        doodle.prediction = label
        doodle.save()

        try:
            data['img'] = __searchImage(lbl['en'], 5)
        except Exception as e:
            raise e
            data['img'] = [
                'https://www.creativefabrica.com/wp-content/uploads/2019/12/23/404-error-flat-icon-vector-Graphics-1.jpg'
            ]

        return Response(data)
    except Exception as e:
        raise 
        print(e)
    data = getSampleGuess()
    return Response(data)

@api_view(['GET', 'POST'])
def drawExperimentApi(request):
    try:
        doodle = Doodle()

        ip = request.META.get('REMOTE_ADDR', None)
        if ip:
            # print(GEO_IP.country_name_by_addr(ip))
            # print(GEO_IP.country_code_by_addr(ip))
            doodle.country = GEO_IP.country_name_by_addr(ip)
            doodle.country_code = GEO_IP.country_code_by_addr(ip)

        data = {}
        rawb64 = json.loads(request.body)["pic"].replace('\n', '')
        doodle.base64 = rawb64

        lbl = pred_b64_img(rawb64)
        data['word'] = lbl

        label = Label.get_or_create()
        doodle.word_en = lbl['en']
        doodle.word = lbl
        doodle.save()

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

