#!/bin/bash

ffuf -w /usr/share/dirb/wordlists/big.txt -u http://$1/FUZZ
