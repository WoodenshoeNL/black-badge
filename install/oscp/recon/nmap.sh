#!/bin/bash

echo $PWD

sudo nmap -Pn -sV -p- -oN nmap-full-quick-$1.txt $1

#sudo nmap -Pn -sV -sS -A -p- --script vuln -O -oA nmap-full-$1.txt $1
