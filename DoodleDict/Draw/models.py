from django.db import models

# Create your models here.

class Drawing(models.Model):
    # drawing = models.JSONField(default=dict, null=True, blank=True)
    dataset_key_id = models.BigIntegerField(null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)
    word = models.CharField(max_length=256, null=True)
    recognized = models.BooleanField(default=False)
    countrycode = models.CharField(max_length=16, null=True)


# -- Stub data

SAMPLES = [
    {
        'word': {
            'en': 'chair',
            'vi': 'ghế',
            'ja': '椅子',
            'fr': 'chaise',
            'ru': 'стул',
        },
        'img': [
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Plastic_Tuinstoel.jpg/200px-Plastic_Tuinstoel.jpg',
            'https://upload.wikimedia.org/wikipedia/commons/8/81/Aalto_chair_front.JPG',
            'https://m.media-amazon.com/images/I/81J5r9dANGL._SL1500_.jpg',
            'https://www.boconcept.com/on/demandware.static/-/Sites-master-catalog/default/dw162d4753/images/370000/373229.jpg',
        ]
    },
    {
        'word': {
            'en': 'bed',
            'vi': 'giường',
            'ja': 'ベッド',
            'fr': 'lit',
            'ru': 'кровать',
        },
        'img': [
            'https://www.boconcept.com/on/demandware.static/-/Sites-master-catalog/default/dw0b805ada/images/1220000/1223156.jpg',
            'https://cb2.scene7.com/is/image/CB2/DondraQueenBedSHS21_1x1',
            'https://www.ikea.com/us/en/images/products/malm-bed-frame-high-black-brown-luroey__0638608_pe699032_s5.jpg',
        ]
    },
    {
        'word': {
            'en': 'clock',
            'vi': 'đồng hồ',
            'ja': '時計',
            'fr': 'l\'horloge',
            'ru': 'Часы',
        },
        'img': [
            'https://www.ikea.com/sg/en/images/products/tjalla-wall-clock__0633571_pe695905_s5.jpg',
            'https://m.media-amazon.com/images/I/812L5zyAmpL._AC_SX466_.jpg',
            'https://charmliving.vn/thumbs/1000x1000x2/upload/product/81flzgxbp9lacsl1500-3838.jpg',
        ]
    },
    {
        'word': {
            'en': 'car',
            'vi': 'xe ô tô',
            'ja': '車',
            'fr': 'auto',
            'ru': 'автомобиль',
        },
        'img': [
            'https://car-images.bauersecure.com/pagefiles/81498/450x300/fordfocus_100.jpg',
            'https://s7g10.scene7.com/is/image/maserati/maserati/international/Models/mc20/mc20-hero.jpg',
            'https://auto1-homepage.prod.mp.auto1.cloud/static/optimized/orange-car-hp-right-mercedez.png',
        ]
    },
    {
        'word': {
            'en': 'apple',
            'vi': 'quả táo',
            'ja': 'アップル',
            'fr': 'pomme',
            'ru': 'яблоко',
        },
        'img': [
            'https://iranfreshfruit.net/wp-content/uploads/2020/01/red-apple-fruit.jpg',
            'https://pbs.twimg.com/profile_images/1283958620359516160/p7zz5dxZ.jpg',
            'https://image.shutterstock.com/image-photo/red-apple-isolated-on-white-260nw-1727544364.jpg',
        ]
    },
]

def getSampleGuess():
    global SAMPLES
    import random
    return SAMPLES[random.randint(0, len(SAMPLES)-1)]
