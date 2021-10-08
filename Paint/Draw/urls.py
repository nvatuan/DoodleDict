from django.urls import path
from .views import drawApi


urlpatterns = [
    path('', drawApi, name='draw'),
]