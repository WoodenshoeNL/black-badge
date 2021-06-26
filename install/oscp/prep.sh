#!/bin/bash

#variables
finduser=$(logname)

################################################################
#Configure Git
################################################################

git config --global user.name "Michel Klomp"
git config --global user.email michel@woodenshoe.org

git config --global credential.helper store

################################################################
#Clone Repos
################################################################

cd ~
git clone https://github.com/woodenshoenl/black-badge
git clone https://github.com/woodenshoenl/black-badge-private
git clone https://github.com/woodenshoenl/lab

################################################################
# Configure tmux
################################################################
#copy tmux config
cp ~/black-badge/install/.tmux.conf ~/.tmux.conf

# add tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

################################################################
# Create tmux and vpn scripts
################################################################
#setup script dir
cd ~

#create start tmux script:
echo "tmux new -s attack" > ~/start-tmux.sh
chmod +x ~/start-tmux.sh

#create attach tmux script:
echo "tmux a -t attack" > ~/attach-tmux.sh
chmod +x ~/attach-tmux.sh

#create start htb vpn script:
echo "sudo openvpn ~/lab/htb/lab_woodenshoe.ovpn" > ~/start-htb-vpn.sh
chmod +x ~/start-htb-vpn.sh

#create start htb vpn script:
echo "sudo openvpn ~/lab/oscp/OS-95945-PWK.ovpn" > ~/start-oscp-vpn.sh
chmod +x ~/start-oscp-vpn.sh

#create start update script:
echo "cd ~/black-badge;git pull;~/black-badge/install/oscp/update.sh" > ~/start-update.sh
chmod +x ~/start-update.sh

################################################################
# Add update ip script
################################################################
cp ~/black-badge/install/oscp/update-ip.sh ./update-ip.sh
chmod +x ./update-ip.sh

################################################################
# add wordlists
################################################################
#unpack rockyou file
cd /usr/share/wordlists
gzip -dq /usr/share/wordlists/rockyou.txt.gz

#unpack sec_lists
cd ~
git clone https://github.com/danielmiessler/SecLists.git 2>/dev/null


################################################################
# add Enum
################################################################
cd ~
mkdir enum 2>/dev/null
cd enum

#get LinEnum script
wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -O LinEnum.sh
chmod +x LinEnum.sh

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
# add Recon
################################################################
cd ~
rm -rf -d recon
cp ~/black-badge/install/oscp/recon . -r

################################################################
# add script
################################################################
cd ~
rm -rf -d script
cp ~/black-badge/install/oscp/script . -r


################################################################
# Install Software / Pimp my kali / Blindpentester
################################################################
#https://github.com/blindpentester/the-essentials/blob/master/the_essentials.sh
#https://github.com/Dewalt-arch/pimpmykali/blob/master/pimpmykali.sh
#update kali
apt update && apt full-upgrade -y

#Fix hushlogin
touch ~/.hughlogin

#set Power Settings
raw_xfce="https://raw.githubusercontent.com/Dewalt-arch/pimpmyi3-config/main/xfce4/xfce4-power-manager.xml"
wget $raw_xfce -O /home/$finduser/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml

#silence pc speaker
echo -e "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

#fix nmap nse scripts
rm -f /usr/share/nmap/scripts/clamav-exec.nse
wget https://raw.githubusercontent.com/nmap/nmap/master/scripts/clamav-exec.nse -O /usr/share/nmap/scripts/clamav-exec.nse
wget https://raw.githubusercontent.com/onomastus/pentest-tools/master/fixed-http-shellshock.nse -O /usr/share/nmap/scripts/http-shellshock.nse

#fix sources
mkdir -p /etc/gcrypt
echo "all" > /etc/gcrypt/hwf.deny

echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list
echo "deb-src http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list

apt update
apt -y install dkms build-essential linux-headers-amd64

#install essentials
apt -y install dkms build-essential autogen automake python3-setuptools python3-distutils python3.9-dev libguestfs-tools cifs-utils $silent

#install Chrome browser
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
dpkg -i /tmp/google-chrome-stable_current_amd64.deb
rm -f /tmp/google-chrome-stable_current_amd64.deb

#install vscode
apt -y install code-oss

#install golang
apt install golang -y

#install pip3
apt install python3-pip -

#install terminator
apt install terminator -y

#install ffuf
if ! [ -x "$(command -v ffuf)" ]
then
	cd /opt
	git clone https://github.com/ffuf/ffuf.git
	cd ffuf
	go build
	ln -sf /opt/ffuf/ffuf /usr/bin/ffuf
fi

#install dirsearch
if ! [ -x "$(command -v dirsearch)" ]
then
	cd /opt/
	git clone https://github.com/maurosoria/dirsearch.git >/dev/null 2>&1
	cd dirsearch
	ln -sf /opt/dirsearch/dirsearch.py /usr/bin/dirsearch >/dev/null 2>&1
fi

#install PEAS
FOLDER=/opt/privilege-escalation-awesome-scripts-suite
if [ -d "$FOLDER" ]
then
	echo "Privilege Escalation Awesome Scripts Suite already exists.  Skipping to next item..."
else
	echo "Installing Privilege Escalation Awesome Scripts Suite..."
	cd /opt/
	git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git >/dev/null 2>&1
fi

#install Reverse Shell Generator
if ! [ -x "$(command -v rsg)" ]
then
	echo "Installing Reverse Shell Generator..."
	cd /opt/
	git clone https://github.com/mthbernardes/rsg.git >/dev/null 2>&1
	cd rsg
	sh install.sh 1> /dev/null
else
	echo "rsg already installed.  moving along..."
fi

#install GTFOlookup
FOLDER=/opt/GTFOBLookup
if [ -d "$FOLDER" ]
then
	echo "$FOLDER already exists.  Skipping to next item..."
else
	echo "Installing GTFOBLookup..."
	cd /opt/
	git clone https://github.com/nccgroup/GTFOBLookup.git >/dev/null 2>&1
	cd GTFOBLookup
	pip3 install -r requirements.txt 1> /dev/null
	python3 gtfoblookup.py update 1> /dev/null
fi

#install Neo4j
apt install neo4j -y

#install Bloodhound
apt install bloodhound -y

#install Sublist3r
apt install sublist3r -y

#install Powercat
FOLDER=/opt/powercat
if [ -d "$FOLDER" ]
then
	echo "powercat is already setup..."
else
	echo "Installing Powercat..."
	cd /opt
	git clone https://github.com/besimorhino/powercat.git >/dev/null 2>&1
fi

#install zephrfish wordlist
FOLDER=/opt/Wordlists
if [ -d "$FOLDER" ]
then
	echo "Wordlists is already setup..."
else
	echo "Getting more wordlists..."
	cd /opt
	git clone https://github.com/ZephrFish/Wordlists.git >/dev/null 2>&1
fi

#install gobuster
apt install gobuster -y

#install recursive_gobuster
FOLDER=/opt/recursive-gobuster
if [ -d "$FOLDER" ]
then
	echo "recursive-gobuster appears to be installed already.  moving along..."
else
	echo "Installing recursive-gobuster..."
	cd /opt/
	git clone https://github.com/epi052/recursive-gobuster.git >/dev/null 2>&1
fi

#install crackmapexec
apt install crackmapexec -y

#install SecLists
apt install seclists -y
cat /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt | head -n -14 > /tmp/clean-jhaddix-dns.txt
mv /tmp/clean-jhaddix-dns.txt /usr/share/seclists/Discovery/DNS/clean-jhaddix-dns.txt

#install pspy
FILE=/opt/pspy/binaries/pspy32s
if [ -f "$FILE" ]
then
	echo "pspy appears to be installed already.  moving along..."
else
	echo "Installing pspy"
	cd /opt
	git clone https://github.com/DominicBreuker/pspy >/dev/null 2>&1
	mkdir -p pspy/binaries
	echo "Snagging pspy binaries to /opt/pspy/binaries..."
	wget -qO- https://github.com/DominicBreuker/pspy | grep "download/" | awk -F "a href=" '{print $2}' | awk -F ">" '{print $1}' | sed 's/"//g'| sed 's/^/wget /g' > /opt/pspy/binaries/snagem.sh
	cd /opt/pspy/binaries
	bash snagem.sh >/dev/null 2>&1
	rm snagem.sh
fi

#Install Feroxbuster
FOLDER=/opt/feroxbuster
if [ -d "$FOLDER" ]
then
        echo "feroxbuster seems to be installed already.  moving along..."
else
        echo "Installing feroxbuster..."
        cd /opt
        git clone https://github.com/epi052/feroxbuster >/dev/null 2>&1
        cd feroxbuster
        ./install-nix.sh
        ln -sf /opt/feroxbuster/feroxbuster /usr/bin/feroxbuster >/dev/null 2>&1
fi

#install Rustscan
wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb -O /tmp/rustscan_2.0.1_amd64.deb
dpkg -i /tmp/rustscan_2.0.1_amd64.deb
rm -f /tmp/rustscan_2.0.1_amd64.deb

#install xsel
apt-get install xsel

#install updog
pip3 install updog

#download pimpmykali
git clone https://github.com/Dewalt-arch/pimpmykali /tmp/pimpmykali

#download blindpentester
git clone https://github.com/blindpentester/the-essentials /tmp/the-essentials

################################################################
# add alias to .zshrc
################################################################
if ! grep -q "create-alias.sh" ~/.zshrc; then
    echo "adding aliases"
    echo "source ~/script/create-alias.sh" >> ~/.zshrc
fi

source ~/.zshrc

echo "################################################################"
echo "# End"
echo "################################################################"
echo "# "
echo "# Press prefix + I in Tmux to install plugins"
echo "# "
echo "# "
echo "# "
echo "# "
echo "################################################################"
