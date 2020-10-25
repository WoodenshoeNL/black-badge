#!/bin/bash

#pull newest black-badge
cd ~/my_data/g/black-badge
git pull

#setup dir
cd ~
mkdir htb
cd htb

#copy reverse shells
cd ~/htb
mkdir reverse-shell
cd reverse-shell
cp ~/my_data/g/black-badge/Doc/CC/Reverse-Shell-scripts/php-reverse-shell.php ./prss.php


#generate keypair for target logon
cd ~/htb
mkdir rsa
cd rsa
ssh-keygen -t rsa -b 4096 -C "htb@woodenshoe" -f ./htb_rsa -q -N ""

