import os
module_dir = os.path.dirname(__file__)  # get current directory

import numpy as np

CATEGORIES = open(os.path.join(module_dir, 'categories.txt'), 'r').read().strip().split('\n')

CATE_PREFIX = 'categories_'
CATE_POSTFIX = '.txt'
CATE_LANG = ['en', 'vi', 'ja', 'ru', 'fr']

DICTIONARY = None
SIZE = 128
TFSERVE_HOST = 'tfserve'
TFSERVE_PORT = '8501'
TFSERVE_MODELNAME = 'doodle_predict'

def load_cate_files():
    global DICTIONARY
    DICTIONARY = []
    mapping = {}
    for lang in CATE_LANG:
        mapping[lang] = open(os.path.join(module_dir, CATE_PREFIX + lang + CATE_POSTFIX), 'r').read().strip().split('\n')

    ## sort
    sorted_idx = np.argsort(mapping[CATE_LANG[0]])
    for lang in CATE_LANG:
        mapping[lang] = [mapping[lang][sidx] for sidx in sorted_idx]

    n = len(mapping[CATE_LANG[0]])
    for i in range(n):
        obj = {}
        for lang in CATE_LANG:
            obj[lang] = mapping[lang][i]

        DICTIONARY.append(obj)
    return True

from PIL import Image
import numpy as np
import json
import os
import io
import base64

def b64_img_to_pil_img(b64txt):
    imgdata = base64.b64decode(b64txt)
    img = Image.open(io.BytesIO(imgdata)).convert('L')
    img = img.resize((128, 128))
    #img.convert('gray')
    return img

model = None
def load_model(file_name='model.h5'):
    import tensorflow as tf
    return tf.keras.models.load_model(os.path.join(module_dir, file_name))

def preprocess(img, **kwargs):
    sz = kwargs.get('size', 128)
    # img = img.resize((sz, sz))
    img = np.asarray(img)/255.0
    img = np.reshape(img, (sz, sz, 1))
    return img

def __y_to_labels(ys):
    global CATEGORIES
    return [CATEGORIES[yi] for yi in ys]
def y_to_labels(ys):
    global DICTIONARY 
    if DICTIONARY == None:
        print('First prediction. Loading labels...')
        load_cate_files()
    return [DICTIONARY[yi] for yi in ys]

def __predict(raw_imgs):
    global model 

    if model==None:
        print('First prediction. Loading model...')
        model = load_model()

    pp_imgs = []
    for img in raw_imgs:
        img = preprocess(img)
        pp_imgs.append(img)
    pp_imgs = np.asarray(pp_imgs)

    pp_y = model.predict(pp_imgs)
    pp_yarg = np.argmax(pp_y, axis=1) 
    return y_to_labels(pp_yarg)

""" Make request to the TFServe server instead of loading a model into ram, much more modulized and efficient
"""
def predict(raw_imgs):
    import requests, json
    pp_imgs = []
    for img in raw_imgs:
        img = preprocess(img)
        pp_imgs.append( np.asarray(img).reshape( (SIZE, SIZE, 1) ) )
    pp_imgs = np.asarray(pp_imgs)

    data = json.dumps({"instances": pp_imgs.tolist()})
    headers = {"content-type": "application/json"}
    json_response = requests.post(
        'http://{}:{}/v1/models/{}:predict'.format(TFSERVE_HOST, TFSERVE_PORT, TFSERVE_MODELNAME), 
        data=data, headers=headers
    )
    print("Request status code:", json_response.status_code)
    
    pp_y = json.loads(json_response.text)['predictions']

    # pp_y = model.predict(pp_imgs)
    pp_yarg = np.argmax(pp_y, axis=1) 
    return y_to_labels(pp_yarg)
 
def pred_b64_img(b64raw):
    pilimg = b64_img_to_pil_img(b64raw)
    labels = predict([pilimg])
    return labels[0]

if __name__ == '__main__':
    b64raws = []
    f = open('b64.txt', 'r')
    for line in f:
        line = line.strip()
        if len(line) != 0:
            b64raws.append(line)
    f.close()

    raw_images = []
    for b64raw in b64raws:
        pilimg = b64_img_to_pil_img(b64raw)
        #print(pilimg.size)
        raw_images.append(pilimg)
    print(raw_images)
    labels = predict2(raw_images)
    print(labels)

