from django.urls import path
from .views import drawApi,drawExperimentApi ,randomImage


urlpatterns = [
    path('doodle/', drawApi, name='draw'),
    path('doodle-experiment/', drawExperimentApi, name='draw-experiment'),
    path('randimg/', randomImage, name='randimg'),

]
