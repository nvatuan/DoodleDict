import sys
import base64
import requests
import json

if __name__ == "__main__":
    if len(sys.argv) < 1:
        print('Need image file name')
    else:
        with open(sys.argv[1], "rb") as f:
            encoded = base64.b64encode(f.read())
            print('Sending request..')
            r = requests.post('http://1509.ddns.net:5100/doodle/', json={'pic':encoded.decode('utf-8')})
            print(r)
            dic = json.loads(r.text)
            print(dic['word']['en'])





