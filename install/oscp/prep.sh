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

## Extra installs https://kashz.gitbook.io/oscp-jewels/kashz-kali

#Add repos
cd /opt/
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git
sudo git clone https://github.com/rebootuser/LinEnum
sudo git clone https://github.com/dievus/threader3000.git
sudo git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git
sudo git clone https://github.com/ivan-sincek/php-reverse-shell
sudo git clone https://github.com/Cryilllic/Active-Directory-Wordlists
sudo git clone https://github.com/dyne/file-extension-list
sudo git clone https://github.com/stealthcopter/deepce.git
sudo git clone https://github.com/Anon-Exploiter/SUID3NUM.git
sudo git clone https://github.com/cddmp/enum4linux-ng.git
sudo git clone https://github.com/bitsadmin/wesng.git
sudo git clone https://github.com/WhiteWinterWolf/wwwolf-php-webshell.git
sudo git clone https://github.com/mzet-/linux-exploit-suggester.git
sudo git clone https://github.com/jondonas/linux-exploit-suggester-2.git
sudo git clone https://github.com/sleventyeleven/linuxprivchecker
sudo git clone https://github.com/diego-treitos/linux-smart-enumeration
sudo git clone https://github.com/rasta-mouse/Sherlock.git
sudo git clone https://github.com/WazeHell/PE-Linux.git
sudo git clone https://github.com/borjmz/aspx-reverse-shell
sudo git clone https://github.com/enjoiz/Privesc.git
sudo git clone https://github.com/r3motecontrol/Ghostpack-CompiledBinaries.git
sudo git clone https://github.com/dirkjanm/krbrelayx
sudo git clone https://github.com/antonioCoco/ConPtyShell
sudo git clone https://github.com/brightio/penelope.git
sudo git clone https://github.com/ohpe/juicy-potato.git
sudo git clone https://github.com/SpiderLabs/ikeforce.git
sudo git clone https://github.com/mchoji/winrm-brute.git
sudo git clone https://github.com/iamkashz/ctf-scripts.git
sudo git clone https://github.com/411Hall/JAWS.git
sudo git clone https://github.com/PowerShellMafia/PowerSploit.git

# rlwrap remmina RDP xclip tree php-curl php-dom gitup exiftool html2text jq
sudo apt install rlwrap remmina xclip redis-tools tree php-dom php-curl python3-git-repo-updater odat python3-pip golang terminator libimage-exiftool-perl html2text jq -y
sudo apt install -y gcc-multilib g++-multilib
sudo gem install evil-winrm
#sudo gitup --add /opt

# fix wfuzz Pycurl is not compiled against Openssl
sudo apt --purge remove python3-pycurl;sudo apt install -y libcurl4-openssl-dev libssl-dev;sudo pip3 install pycurl wfuzz

# Autorecon
cd /opt; sudo git clone https://github.com/Tib3rius/AutoRecon.git
cd /opt/AutoRecon;sudo pip3 install -r requirements.txt; sudo python3 -m pip install .

# printspoofer-exe
sudo mkdir /opt/printspoofer-exe; cd /opt/printspoofer-exe/; sudo wget https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer32.exe; sudo wget https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer64.exe; cd ~;

# juicy
sudo mkdir /opt/juicypotato-exe; cd /opt/juicypotato-exe; sudo wget https://github.com/ohpe/juicy-potato/releases/download/v0.1/JuicyPotato.exe -O JuicyPotato64.exe; sudo wget https://github.com/ivanitlearning/Juicy-Potato-x86/releases/download/1.2/Juicy.Potato.x86.exe -O JuicyPotato.exe; cd ~;

# roguepotato-exe
sudo mkdir /opt/roguepotato-exe; cd /opt/roguepotato-exe; sudo wget https://github.com/antonioCoco/RoguePotato/releases/download/1.0/RoguePotato.zip; sudo unzip RoguePotato.zip; sudo rm RoguePotato.zip; cd ~;

# psexec
sudo mkdir /opt/psexec/; cd /opt/psexec/; sudo wget https://download.sysinternals.com/files/PSTools.zip; sudo unzip PSTools.zip; sudo rm PSTools.zip; cd ~;

# nc
mkdir /tmp/files; cd /tmp; wget https://eternallybored.org/misc/netcat/netcat-win32-1.12.zip; unzip netcat-win32-1.12.zip -d /tmp/files/; sudo mkdir /opt/nc; sudo cp /tmp/files/nc* /opt/nc/; sudo cp /usr/bin/nc /opt/nc/nc; cd ~;

# accesschk
sudo mkdir /opt/accesschk; cd /opt/accesschk; sudo wget https://download.sysinternals.com/files/AccessChk.zip; sudo unzip AccessChk.zip; sudo rm AccessChk.zip; cd ~;
cd /opt; sudo mkdir /opt/socat;

# socat
sudo mkdir --parents /opt/socat/linux; cd /opt/socat/linux; sudo wget https://github.com/3ndG4me/socat/releases/download/v1.7.3.3/socatx86.bin -O socat; sudo wget https://github.com/3ndG4me/socat/releases/download/v1.7.3.3/socatx64.bin -O socat64; sudo chmod +x *; sudo mkdir /opt/socat/windows; cd /opt/socat/windows; sudo wget https://github.com/3ndG4me/socat/releases/download/v1.7.3.3/socatx86.exe -O socat.exe; sudo wget https://github.com/3ndG4me/socat/releases/download/v1.7.3.3/socatx64.exe -O socat64.exe; cd ~;

#sysinternals
sudo mkdir -p /opt/sysinternals/sigcheck-exe; cd /opt/sysinternals/sigcheck-exe/; sudo wget https://download.sysinternals.com/files/Sigcheck.zip; sudo unzip Sigcheck.zip; sudo rm Sigcheck.zip; cd ~;
sudo mkdir /opt/sysinternals/strings-exe; cd /opt/sysinternals/strings-exe/; sudo wget https://download.sysinternals.com/files/Strings.zip; sudo unzip Strings.zip; sudo rm Strings.zip; cd ~;
sudo mkdir /opt/sysinternals/tcpview-exe; cd /opt/sysinternals/tcpview-exe/; sudo wget https://download.sysinternals.com/files/TCPView.zip; sudo unzip TCPView.zip; sudo rm TCPView.zip; cd ~;

# https://gist.github.com/tothi/ab288fb523a4b32b51a53e542d40fe58
sudo mkdir /opt/powershell_encoded_revshell/; cd /opt/powershell_encoded_revshell/; sudo wget https://gist.githubusercontent.com/tothi/ab288fb523a4b32b51a53e542d40fe58/raw/40ade3fb5e3665b82310c08d36597123c2e75ab4/mkpsrevshell.py -O powershell_encoded_revshell.py; python3 powershell_encoded_revshell.py; cd ~;

# chisel
cd ~; curl https://i.jpillora.com/chisel! | sudo bash
sudo mkdir --parents /opt/chisel/linux; cd /opt/chisel/linux; sudo wget https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_linux_amd64.gz; sudo wget https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_linux_386.gz; sudo gzip -d *; sudo mv chisel_1.7.6_linux_386 chisel; sudo mv chisel_1.7.6_linux_amd64 chisel64;
sudo mkdir /opt/chisel/windows; cd /opt/chisel/windows; sudo wget https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_windows_386.gz; sudo wget https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_windows_amd64.gz; sudo gzip -d *; sudo mv chisel_1.7.6_windows_386 chisel.exe; sudo mv chisel_1.7.6_windows_amd64 chisel64.exe; cd ~;

# mongosh client setup
cd ~; wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -; echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list; sudo apt update; sudo apt install -y mongodb-mongosh mongodb-org-shell; mongosh --version; cd ~;

# oracle-tns
pip3 install cx_Oracle --upgrade; sudo mkdir /opt/oracle-tns; cd /opt/oracle-tns/; sudo wget 'https://firebasestorage.googleapis.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-LcreDSG0Hi8mv8n8DIw%2F-LcrnYv40ILvFrpjKRkb%2Fsids-oracle.txt?alt=media&token=8206a9f6-af86-4a49-ac71-179ca973d836' -O sids-oracle.txt; sudo wget 'https://firebasestorage.googleapis.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-LcreDSG0Hi8mv8n8DIw%2F-Lcrmdr8nRaj1Ea6JQqm%2Fusers-oracle.txt?alt=media&token=e1dc7604-86d8-4fe6-8dcc-f8cb5167c83d' -O users-oracle.txt; sudo wget 'https://firebasestorage.googleapis.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-LcreDSG0Hi8mv8n8DIw%2F-LcrmhoNYnuxhr1Sy7A1%2Fpass-oracle.txt?alt=media&token=0879b74c-07eb-40a7-8038-e5f4b42621f3' -O pass-oracle.txt;cd ~;

sudo apt install oracle-instantclient-sqlplus

# sudo updatedb; locate libsqlplus.so
/usr/lib/oracle/19.6/client64/lib/libsqlplus.so

# sqlplus vars (subl ~/.zshrc)
export ORACLE_HOME=<PATH-OF-libsqlplus.so> (without filename)
export LD_LIBRARY_PATH="$ORACLE_HOME"
export PATH="$ORACLE_HOME:$PATH"

# test
sqlplus -V

#postman
cd ~;wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman.tar.gz; cd /opt; sudo tar -xvf /tmp/postman.tar.gz; rm /tmp/postman.tar.gz;
sudo ln -s /opt/Postman/app/postman /usr/local/bin/;cd ~;

# rockyou extract
cd /usr/share/wordlists; sudo gzip -d /usr/share/wordlists/rockyou.txt.gz;cd ~

# enum4linux update
sudo wget https://raw.githubusercontent.com/CiscoCXSecurity/enum4linux/master/enum4linux.pl -O /usr/share/enum4linux/enum4linux.pl


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
