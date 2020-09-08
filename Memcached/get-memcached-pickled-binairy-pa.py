
from pymemcache.client.base import Client
import pickle
import binascii

def retrieve3(key):
    result = client.get_multi(['%s-%s' % (key, i) for i in xrange(32)])
    serialized = ''
    for i in range(25):
        serialized = serialized + result[key + '-' + str(i)]
    return binascii.unhexlify(serialized)

client = Client(('localhost', 11211))
print retrieve3("flag3")
