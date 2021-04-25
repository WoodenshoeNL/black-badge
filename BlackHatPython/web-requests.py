# pip install requests

import requests
import time

url = 'http://boodelyboo.com'
response = requests.get(url)
print(response.text)

time.sleep(2)

data = {'user' : 'tim', 'passwd': '31337'}
response = requests.post(url, data=data)
print(response.text)
