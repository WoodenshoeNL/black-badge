#!/bin/bash

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


################################################################
# copy scripts to tmp
################################################################
cd /tmp
mkdir exploit
cp ~/black-badge-private/tools/get-url.py /tmp/exploit/
chmod +x /tmp/exploit/get-url.py



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
