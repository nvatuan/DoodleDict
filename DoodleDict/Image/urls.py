from django.urls import path
from .views import searchImage

urlpatterns = [
    path('searchImage/', searchImage, name='translate'),
]
