from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response

from Draw.models import getSampleGuess

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
def randomImage(request):
    import requests
    r = requests.get('https://picsum.photos/400')
    data = {
        'url': r.url
    }
    return Response(data)
## -- 

