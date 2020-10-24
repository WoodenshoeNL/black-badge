from pymemcache.client.base import Client
import pprint

client = Client(('localhost', 11211))

pp = pprint.PrettyPrinter(indent=4)
pp.pprint(client.stats("items"))
pp.pprint(client.stats("cachedump","4","0"))
