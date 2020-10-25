#!/bin/bash

ip="10.10.14.9"

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




################################################################
#script dir
cd ~/htb
mkdir script
cd script

#copy add public key script
cp ~/my_data/g/black-badge/K/Battle/Red/add-pubkey.sh ./add-pubkey.sh
chmod +x ./add-pubkey.sh





################################################################


#change ip addresses in scripts
sed -i "s/10.10.10.10/$ip/g" ~/htb/script/*

#change ip addresses in reverse shell
sed -i "s/10.10.10.10/$ip/g" ~/htb/reverse-shell/*
