#!/bin/bash

sudo nmap -Pn -sV -sS -A -p- --script vuln -O -oA nmap-full-$1.txt $1
