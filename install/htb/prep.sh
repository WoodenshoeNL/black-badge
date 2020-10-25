#!/bin/bash

ip="10.10.14.9"

#pull newest black-badge
cd ~/my_data/g/black-badge
git pull >/dev/null

#setup dir
cd ~
mkdir htb 2>/dev/null
cd htb

#copy reverse shells
cd ~/htb
mkdir reverse-shell 2>/dev/null
cd reverse-shell
cp ~/my_data/g/black-badge/Doc/CC/Reverse-Shell-scripts/php-reverse-shell.php ./prss.php


#generate keypair for target logon
cd ~/htb
mkdir rsa 2>/dev/null
cd rsa
ssh-keygen -t rsa -b 4096 -C "htb@woodenshoe" -f ./htb_rsa -q -N "" <<<y 2>&1 >/dev/null




################################################################
#script dir
cd ~/htb
mkdir script 2>/dev/null
cd script

#copy add public key script
cp ~/my_data/g/black-badge/K/Battle/Red/add-pubkey.sh ./add-pubkey.sh
chmod +x ./add-pubkey.sh





################################################################


#change ip addresses in scripts
sed -i "s/10.10.10.10/$ip/g" ~/htb/script/*

#change ip addresses in reverse shell
sed -i "s/10.10.10.10/$ip/g" ~/htb/reverse-shell/*


#end ########
cd ~/htb
