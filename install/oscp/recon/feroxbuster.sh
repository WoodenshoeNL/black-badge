#!/bin/bash

feroxbuster --url http://$1 -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -o ferox-extended-$1.txt --add-slash --extract-links
