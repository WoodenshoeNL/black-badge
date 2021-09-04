from bs4 import BeautifulSoup as bs
import requests
import base64


url = 'http://10.129.24.72/transfer.aspx'

webshell = "run.jpg"

files = {'image': (webshell, "test")}

#with requests.Session() as s:
#    response = s.post(url, files=files, verify=False)
#    print(response.text)
