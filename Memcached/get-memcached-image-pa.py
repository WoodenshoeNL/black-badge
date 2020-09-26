from pymemcache.client.base import Client
import pickle

def retrieve(key):
    result = client.get_multi(['%s-%s' % (key, i) for i in xrange(12)])
    serialized = ''
    for i in range(12):
        serialized = serialized + result[key + '-' + str(i)]
    return pickle.loads(serialized)


client = Client(('192.28.102.3', 11211))
result = client.get('image')
print result

