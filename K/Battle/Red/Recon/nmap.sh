#!/bin/bash

sudo nmap -sV -sS -A -p- --script vuln -O -oA nmap-full-$1.txt $1
