#!/bin/bash

echo "################################################################"
echo "# Start Nmap scans for $1"
echo "################################################################"

echo "Running: sudo nmap -Pn -sV --top-ports 20 -T4 -oN nmap-top20-quick.txt $1"
sudo nmap -Pn -sS --top-ports 20 --min-rate 10000 -T4 -oN nmap-top20-quick.txt $1

echo "################################################################"

echo "Running: sudo nmap -Pn -sS -p- -T4 -oN nmap-full-quick.txt $1"
sudo nmap -Pn -sS -sV -p- --min-rate 10000 -T4 -oN nmap-full-quick.txt $1
