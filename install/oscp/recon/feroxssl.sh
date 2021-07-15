#!/bin/bash

feroxbuster --url https://$1 -o ferox-ssl-init-$1.txt --insecure --dont-filter

feroxbuster -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt --url https://$1 -o ferox-ssl-extended-m-$1.txt --insecure --dont-filter --add-slash --extract-links -x php htm html json js xml asp aspx txt bak sh yml py pl
