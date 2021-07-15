#!/bin/bash

feroxbuster --url http://$1 -o ferox-init-$1.txt

#feroxbuster -w /usr/share/dirb/wordlists/big.txt --url http://$1 -o ferox-init-b-$1.txt
#feroxbuster -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt --url http://$1 -o ferox-init-m-$1.txt


feroxbuster --url http://$1 -o ferox-extended-$1.txt --add-slash --extract-links

#feroxbuster -w /usr/share/dirb/wordlists/big.txt --url http://$1 -o ferox-extended-b-$1.txt --add-slash --extract-links -x php htm html json js xml asp aspx txt bak sh yml py pl
feroxbuster -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt --url http://$1 -o ferox-extended-m-$1.txt --extract-links -x php htm html json js xml asp aspx txt bak sh yml py pl
