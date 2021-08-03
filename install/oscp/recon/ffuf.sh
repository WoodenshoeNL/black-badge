#!/bin/bash

ffuf -w /usr/share/dirb/wordlists/big.txt -u http://$1/FUZZ > ffuf-init-$1.txt

ffuf -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -u http://$1/FUZZ >> ffuf-init-$1.txt
