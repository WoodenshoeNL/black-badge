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

#copy vpn script:
cp ~/lab/vpn-scripts/start-*-vpn.sh .
chmod +x start-*-vpn.sh

#create start update script:
echo "cd ~/black-badge;git pull;~/black-badge/install/oscp/update.sh" > ~/start-update.sh
chmod +x ~/start-update.sh

################################################################
# Add update ip script
################################################################
cp ~/black-badge/install/oscp/update-ip.sh ./update-ip.sh
chmod +x ./update-ip.sh

# Switch to root
sudo su

################################################################
# add wordlists
################################################################
#unpack rockyou file
cd /usr/share/wordlists
gzip -dq /usr/share/wordlists/rockyou.txt.gz

# copy rockyou to /opt
cp /usr/share/wordlists/rockyou.txt /opt/rockyou.txt

#unpack sec_lists
cd /opt
git clone https://github.com/danielmiessler/SecLists.git 2>/dev/null


################################################################
# Install Software / Pimp my kali / Blindpentester
################################################################
#https://github.com/blindpentester/the-essentials/blob/master/the_essentials.sh
#https://github.com/Dewalt-arch/pimpmykali/blob/master/pimpmykali.sh
#update kali
apt update && apt full-upgrade -y

#Fix hushlogin
touch ~/.hughlogin

#download pimpmykali
git clone https://github.com/Dewalt-arch/pimpmykali /tmp/pimpmykali

#download blindpentester
git clone https://github.com/blindpentester/the-essentials /tmp/the-essentials

# Autorecon
cd /opt; sudo git clone https://github.com/Tib3rius/AutoRecon.git
cd /opt/AutoRecon;sudo pip3 install -r requirements.txt; sudo python3 -m pip install .

## More installs

# install rlwrap
sudo apt install rlwrap

################################################################
# add alias to .zshrc
################################################################
cd ~
mkdir script
cp ~/black-badge/install/oscp/script/create-alias.sh ~/script/
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
