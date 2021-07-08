#!/bin/bash

feroxbuster --url http://$1 -o ferox-init-$1.txt


feroxbuster -w /usr/share/dirb/wordlists/big.txt --url http://$1 -o ferox-initb-$1.txt

feroxbuster -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt --url http://$1 -o ferox-initm-$1.txt


