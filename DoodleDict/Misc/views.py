from django.http import HttpResponse
from rest_framework.decorators import api_view

@api_view(['GET'])
def __loader_verify(request):
    return  HttpResponse('loaderio-96bbbfc70dd1e24fde8cfd265dc91382', content_type='text/plain')
