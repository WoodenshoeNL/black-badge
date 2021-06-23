#!/bin/bash

echo "Running: sudo nmap -Pn -sV -p- -T4 -oN nmap-full-quick.txt $1"
sudo nmap -Pn -sV -p- -T4 -oN nmap-full-quick.txt $1

echo "################################################################"

echo "sudo nmap -Pn -sV -sS -A -p- --script vuln -T4 -O -oN nmap-full-A.txt $1"
sudo nmap -Pn -sV -sS -A -p- --script vuln -T4 -O -oN nmap-full-A.txt $1
