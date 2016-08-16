#!/bin/bash
#Script to setup my environment July 2016
#turn color on in vim
touch .vimrc
chmod 770 .vimrc
echo 'syntax on' >> .vimrc
#get locate, nmap
sudo apt-get install nmap locate -y
#
