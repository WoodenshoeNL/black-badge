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
# Refresh Recon
################################################################
cd ~
rm -rf -d recon

################################################################
# Refresh script
################################################################
cd ~
rm -rf -d script
cp ~/black-badge/install/oscp/script . -r

################################################################
# Refresh ip
################################################################
#change ip addresses in scripts
sed -i "s/10.10.10.10/$ip/g" ~/script/*

#change ip addresses in reverse shell
#sed -i "s/10.10.10.10/$ip/g" ~/reverse-shell/*
#sed -i "s/192.168.254.1/$ip/g" ~/reverse-shell/*

################################################################
# add alias to .zshrc
################################################################
if ! grep -q "create-alias.sh" ~/.zshrc; then
    echo "adding aliases"
    echo "source ~/script/create-alias.sh" >> ~/.zshrc
fi

#source ~/.zshrc
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
