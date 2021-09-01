#!/bin/bash

echo "################################################################"
echo "# Start Nmap scans for $1"
echo "################################################################"

echo "Running: sudo nmap -Pn -sV --top-ports 20 -T4 -oN nmap-top20-quick.txt $1"
sudo nmap -Pn -sV --top-ports 20 --min-rate 10000 -T4 -oN nmap-top20-quick.txt $1

echo "################################################################"

echo "Running: sudo nmap -Pn -sS -p- -T4 -oN nmap-full-quick.txt $1"
sudo nmap -Pn -sS -p- --min-rate 10000 -T4 -oN nmap-full-quick.txt $1

echo "################################################################"

echo "sudo nmap -Pn -sS -p- --script vuln --min-rate 10000 -T4 -O -oN nmap-full-vuln.txt $1"
sudo nmap -Pn -sS -p- --script vuln --min-rate 10000 -T4 -oN nmap-full-vuln.txt $1

echo "################################################################"

echo "sudo nmap -Pn -sV -sS -A -p- --script discovery --version-all --min-rate 10000 -T4 -O -oN nmap-full-Discover.txt $1"
sudo nmap -Pn -sV -sS -A -p- --script discovery --version-all --min-rate 10000 -T4 -O -oN nmap-full-Discover.txt $1

echo "################################################################"

echo "sudo nmap -Pn -sU -p- --min-rate 10000 -T4 -oN nmap-full-UDP.txt $1"
sudo nmap -Pn -sU -p- --min-rate 10000 -T4 -oN nmap-full-UDP.txt $1
