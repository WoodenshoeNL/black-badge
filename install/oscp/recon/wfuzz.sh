#!/bin/bash

echo "################################################################"
echo "# Start wfuzz scans for $1 with domain $2"
echo "# Usage: wfuzz 10.10.10.10 test.htb"
echo "################################################################"

echo "Running: sudo wfuzz -c -u http://$1 -H "Host: FUZZ.$2" -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt"
sudo wfuzz -c -u http://$1 -H "Host: FUZZ.$2" -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt --oF wfuzz-$1-$2.txt
