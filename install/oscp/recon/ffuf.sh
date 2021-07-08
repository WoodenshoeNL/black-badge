#!/bin/bash

ffuf -w /usr/share/dirb/wordlists/big.txt -u http://$1/FUZZ > ffuf-init-$1.txt

ffuf -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -u http://$1/FUZZ >> ffuf-init-$1.txt


ffuf -w /usr/share/dirb/wordlists/big.txt -e .sh,.txt,.php,.htb,.py,.pl,.bak,.htm,.html,.js,.asp,.aspx,.json,.yml -u http://$1/FUZZ > ffuf-ext-$1.txt

ffuf -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -e .sh,.txt,.php,.htb,.py,.pl,.bak,.htm,.html,.js,.asp,.aspx,.json,.yml -u http://$1/FUZZ >> ffuf-ext-$1.txt


ffuf -w /usr/share/dirb/wordlists/big.txt -recursion -recursion-depth 3 -u http://$1/FUZZ > ffuf-recursion-$1.txt

ffuf -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -recursion -recursion-depth 3 -u http://$1/FUZZ >> ffuf-recursion-$1.txt
