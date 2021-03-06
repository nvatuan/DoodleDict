from django.db import models

# Create your models here.

class Label(models.Model):
    word_en = models.CharField(max_length=512, null=True, unique=True)
    word = models.JSONField(default=dict, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        if self.word_en:
            return self.word_en
        return "Label #"+str(self.id)

class Doodle(models.Model):
    country = models.CharField(max_length=256, null=True)
    country_code = models.CharField(max_length=256, null=True)
    base64 = models.TextField()
    prediction = models.ForeignKey(Label, null=True, blank=True, on_delete=models.SET_NULL, related_name="predicted_as")
    actual_label = models.ForeignKey(Label, null=True, blank=True, on_delete=models.SET_NULL, related_name="actually_as")

    created_at = models.DateTimeField(auto_now_add=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True, blank=True)
    deleted_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        if self.prediction:
            return "Pred as '{}'".format(self.prediction.word_en)
        return "Unknown"


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
