#!/bin/bash

sudo nmap -sV -sS -A -oA nmap-quick-$1.txt $1
