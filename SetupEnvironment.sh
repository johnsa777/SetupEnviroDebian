#!/bin/bash
#Shell to setup my environment
#This setup is appropriate for ephemeral sessions on google cloud services

#Change to root
su root
cd ~

#turn color on in vim if there are no vim settings
if [ ! -f .vimrc ]; then
touch .vimrc
chmod 770 .vimrc
echo 'syntax on' >> .vimrc
fi

#get locate, nmap
sudo apt-get install nmap locate -y

#get zsh and oh-my-zsh
sudo apt-get install zsh -y
sudo sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
#dowload Honukai theme and reloading shell
#wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme
#mv honukai.zsh-theme /home/$USER/.oh-my-zsh/themes/
sed -i -e 's/robbyrussell/honukai/' .zshrc  #set theme
source .zshrc #reloading shell settings