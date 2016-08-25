#!/bin/bash
#Shell to setup my environment
#This setup is appropriate for ephemeral sessions on google cloud services
#Turn color n on in vim if there are no vim settings
if [ ! -f /root/.vimrc ]; then
    touch /root/.vimrc
    chmod 770 /root/.vimrc
    echo 'syntax on' >> /root/.vimrc
fi
#get locate, nmap
sudo apt-get install nmap locate -y

#get zsh and oh-my-zsh
sudo rm -r /root/.oh-my-zsh; echo '*** delete prev oh-my-zsh install if present'
sudo apt-get install zsh -y
sudo sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
#dowload Honukai theme and reloading shell
#wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme
#mv honukai.zsh-theme /home/$USER/.oh-my-zsh/themes/
echo '*** setting template'
sed -i -e 's/robbyrussell/honukai/' /root/.zshrc  #set theme
source .zshrc #reloading shell settings