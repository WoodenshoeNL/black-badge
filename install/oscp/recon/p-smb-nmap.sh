#!/bin/bash

echo "Running: sudo nmap -sS -p 139,445 --script "smb*" -oN nmap-smb-scripts.txt $1"
sudo nmap -sS -p 139,445 --script "smb*" -oN nmap-smb-scripts.txt $1
