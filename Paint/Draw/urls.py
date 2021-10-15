from django.urls import path
from .views import drawApi, randomImage


urlpatterns = [
    path('doodle', drawApi, name='draw'),
    path('randimg', randomImage, name='randimg'),
]
