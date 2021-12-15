from django.urls import path
from .views import __loader_verify


urlpatterns = [
    path('loaderio-96bbbfc70dd1e24fde8cfd265dc91382/', __loader_verify),
]
