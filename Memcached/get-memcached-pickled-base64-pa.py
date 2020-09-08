from pymemcache.client.base import Client
import pickle
import base64

def retrieve2(key):
    result = client.get_multi(['%s-%s' % (key, i) for i in xrange(32)])
    serialized = ''
    for i in range(17):
        serialized = serialized + result[key + '-' + str(i)]
    return base64.b64decode(serialized)

client = Client(('localhost', 11211))
print retrieve2("flag2")
