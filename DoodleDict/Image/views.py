from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import Image
from Draw.models import Label
import asyncio, requests

import os
from django.conf import settings  

unsplash_key = getattr(settings, 'UNSPLASH_ACCESS_KEY', None)
unsplash_get_cnt = getattr(settings, 'UNSPLASH_GET_COUNT', 5)
unsplash_img_dim = getattr(settings, 'UNSPLASH_IMG_DIM', (1600,900))
pred_b64_img = getattr(settings, "PREDICT_B64", None)

# Create your views here.
async def retrieve_imgs(keyword, count):
    r = requests.get(
        'https://api.unsplash.com/search/photos?query={}'.format(keyword),
        headers = {
            'Accept-Version': 'v1',
            'Content-Type': 'application/json',
            'Authorization': 'Client-ID {}'.format(unsplash_key)
        }
    )
    imgs = []
    for i in range(count):
        try:
            raw = r.json()['results'][i]['urls']['raw']
            raw += '&w={}&h={}&fit=crop'.format(*unsplash_img_dim)
            imgs.append(raw)
        except IndexError:
            break
    return imgs

def __searchImage(keyword, count):
	label=None
	try:
		label = Label.objects.get(word_en=keyword)
	except Label.DoesNotExist:
		label = Label.objects.create(word_en=keyword)

	images = Image.objects.filter(label=label)[:count]
	if len(images) < count:
		get_imgs = asyncio.run(retrieve_imgs(keyword, count))

		image_obj = []
		for get_img in get_imgs:
			image_obj.append( Image(label=label, url=get_img, status="OK") )
		images = Image.objects.bulk_create(image_obj)

	image_urls = [image.url for image in images]	
	return image_urls

@api_view(['GET'])
def searchImage(request):
	try:
		keyword = request.GET.get('keyword')
		if not keyword:
			return Response("You need a keyword", status=status.HTTP_400_BAD_REQUEST)

		try:
			count = int(request.GET.get('count', 5))
			count = min(count, 20)
			count = max(count, 5)
		except:
			count = 5
		
		return Response(__searchImage(keyword, count))

	except Exception as e:
		print("Exception ", e)
	return Response(['https://www.creativefabrica.com/wp-content/uploads/2019/12/23/404-error-flat-icon-vector-Graphics-1.jpg'])