#!/bin/bash
#Shell to setup my environment

#turn color on in vim
touch .vimrc
chmod 770 .vimrc
echo 'syntax on' >> .vimrc

#get locate, nmap
sudo apt-get install nmap locate -y

#get zsh and oh-my-zsh
sudo apt-get install zsh -y
sudo sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"