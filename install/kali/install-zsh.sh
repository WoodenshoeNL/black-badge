#!/bin/bash

sudo apt install -y zsh zsh-syntax-highlighting zsh-autosuggestions

cp /etc/skel/.zshrc ~/

chsh -s /bin/zsh
