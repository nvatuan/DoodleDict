from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response

# Create your views here.

@api_view(['GET'])
def drawApi(request):
    data = {
        'guess': {
            'en': 'chair',
            'vn': 'ghế',
        },
        'img': ['https://picsum.photos/id/1002/367/267']
    }
    return Response(data)