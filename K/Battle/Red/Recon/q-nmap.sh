#!/bin/bash

sudo nmap -Pn -sV -sS -A -oA nmap-quick-$1.txt $1
