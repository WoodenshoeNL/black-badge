#!/bin/bash

gobuster dir -w /usr/share/dirbuster/wordlists/directory-list-lowercase-2.3-medium.txt -t 50 -u http://$1/
