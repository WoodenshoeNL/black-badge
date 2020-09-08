from pymemcache.client.base import Client
import pickle

def retrieve(key):
    result = client.get_multi(['%s-%s' % (key, i) for i in xrange(12)])
    serialized = ''
    for i in range(12):
        serialized = serialized + result[key + '-' + str(i)]
    return serialized

client = Client(('localhost', 11211))
print retrieve("flag")
