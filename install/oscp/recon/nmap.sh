#!/bin/bash

echo "################################################################"
echo "# Start Nmap scans for $1"
echo "################################################################"

echo "Running: sudo nmap -Pn -sV --top-ports 20 -T4 -oN nmap-top20-quick.txt $1"
sudo nmap -Pn -sV --top-ports 20 -T4 -oN nmap-top20-quick.txt $1

echo "################################################################"

echo "Running: sudo nmap -Pn -sS -p- -T4 -oN nmap-full-quick.txt $1"
sudo nmap -Pn -sS -p- -T4 -oN nmap-full-quick.txt $1

echo "################################################################"

echo "sudo nmap -Pn -sV -sS -A -p- --script vuln,discovery --version-all -T4 -O -oN nmap-full-A.txt $1"
sudo nmap -Pn -sV -sS -A -p- --script vuln,discovery --version-all -T4 -O -oN nmap-full-A.txt $1

echo "################################################################"

echo "sudo nmap -Pn -sV -sU -A -p- --script vuln,discovery --version-all -T4 -O -oN nmap-full-UDP-A.txt $1"
sudo nmap -Pn -sV -sS -A -p- --script vuln,discovery --version-all -T4 -O -oN nmap-full-UDP-A.txt $1
