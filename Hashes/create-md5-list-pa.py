
import hashlib
filepath = '/root/wordlists/100-common-passwords.txt'
wordlist = 'wordlistmd5.txt'
f = open(wordlist, "a")
with open(filepath) as fp:
   line = fp.readline()
   while line:
        line = line.strip()
        hash_object = hashlib.md5(line.encode('UTF-8'))
        md5 = hash_object.hexdigest()
        print("{}: {}".format(md5, line.strip()))
        f.write('{x}\n'.format(x=md5))
        line = fp.readline()

f.close()

