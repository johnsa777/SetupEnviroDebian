#!/bin/bash
#Shell to setup Debian environment
#This setup is appropriate for ephemeral sessions or new systems

#Change system password
while true; do
    read -p "\033[42mWould you like to change your user password? (y/n)\033[m" yn
    case $yn in
        [Yy]* ) sudo passwd; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

#Redo ssh keys
while true; do
    read -p "Would you like to regenerate your ssh keys (y/n)" yn
    case $yn in
        [Yy]* ) sudo ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521 -y; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

#Remove identification banner
sudo rm /etc/issue
sudo rm /etc/motd
#update system
sudo apt update -y
sudo apt dist-upgrade -y
#install software
sudo apt install nmap locate vim -y
sudo apt install htop -y
#setup cron job to update system continuously 
if !(crontab -l | grep -q 'apt update'); then
        crontab -l > mycron
        #echo new cron into cron file
        echo "08 04 * * * apt update -y;apt dist-upgrade -y;apt clean -y" >> mycron
        #install new cron file
        sudo crontab mycron
        rm mycron
fi
#Turn color on in vim
if (grep -q "syntax on" "/root/.vimrc") 
then
        echo 'vim settings present'
else
        sudo touch /root/.vimrc
        sudo chmod 770 /root/.vimrc
        sudo echo "syntax on" >> /root/.vimrc
fi
#get zsh and oh-my-zsh
if [ -e /root/.oh-my-zsh ]
then
        echo 'zsh present'
else
        sudo apt install zsh -y
        sudo sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
        #set maran theme
        sed -i -e 's/robbyrussell/maran/' /root/.zshrc  #set theme
        source .zshrc #reloading shell settings
fi
echo 'END OF SCRIPT'
