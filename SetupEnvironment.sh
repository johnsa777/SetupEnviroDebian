#!/bin/bash
#Shell to setup Debian environment
#https://github.com/johnsa777/SetupEnviroDebian
#This setup is appropriate for ephemeral sessions or new systems
#To run make the script executable "chmod 755 SetupEnviroDebian.sh"
#Run with sudo

#Setting up terminal color and saying hello
RESET="\033[0m"
GREEN="\033[42m"
echo $(echo -e $GREEN"HI, this is a script that sets up a Debian environment"$RESET);

#Change system name
while true; do
    read -p "$(echo -e $GREEN"Would you like to change machine name (y/n)"$RESET)" yn
    case $yn in
        [Yy]* ) 
            read -p "$(echo -e $GREEN"Enter machine name"$RESET)" MachineName
            sudo hostnamectl set-hostname $MachineName
            break;;
        [Nn]* ) break;;
        * ) echo $(echo -e $GREEN"Please answer yes or no."$RESET);;
    esac
done

#Change system password
while true; do
    read -p "$(echo -e $GREEN"Would you like to change your user password? (y/n)"$RESET)" yn
    case $yn in
        [Yy]* ) sudo passwd; break;;
        [Nn]* ) break;;
        * ) echo $(echo -e $GREEN"Please answer yes or no."$RESET);;
    esac
done

#setup cron job to update system continuously 
while true; do
    read -p "$(echo -e $GREEN"Would you like to update system automatically every day? (y/n)"$RESET)" Update
    case $Update in
        [Yy]* ) CronOn=1; break;;
        [Nn]* ) CronOn=0; break;;
        * ) echo $(echo -e $GREEN"Please answer yes or no."$RESET);;
    esac
done

if [[ "$CronOn" -eq 1 ]];then
    if (!(crontab -l | grep -q 'apt update')); then
            crontab -l > mycron
            #echo new cron into cron file
            echo "08 04 * * * apt update -y;apt dist-upgrade -y;apt clean -y" >> mycron
            #install new cron file
            sudo crontab mycron
            rm mycron
    fi
fi

#Redo ssh keys
while true; do
    read -p "$(echo -e $GREEN"Would you like to regenerate your ssh keys (y/n)"$RESET)" yn
    case $yn in
        [Yy]* ) sudo ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521 -y; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

#Removing identification banner
echo $(echo -e $GREEN"Removing identification banner"$RESET);
sudo rm /etc/issue
sudo rm /etc/motd
#Updating system
echo $(echo -e $GREEN"Updating system"$RESET);
sudo apt update -y
sudo apt dist-upgrade -y
#Installing nmap, vim, htop
echo $(echo -e $GREEN"Installing nmap, vim, htop"$RESET);
sudo apt install nmap locate vim -y
sudo apt install htop -y
#Turning color on in vim
echo $(echo -e $GREEN"Turning color on in vim"$RESET);
if (grep -q "syntax on" "/root/.vimrc") 
then
        echo 'vim settings present'
else
        sudo touch /root/.vimrc
        sudo chmod 770 /root/.vimrc
        sudo echo "syntax on" >> /root/.vimrc
fi
#Installing zsh and oh-my-zsh
echo $(echo -e $GREEN"Installing zsh and oh-my-zsh"$RESET);
if [ -e /root/.oh-my-zsh ]
then
        echo $(echo -e $GREEN"zsh already present"$RESET);
else
        sudo apt install zsh -y
        sudo sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
        #set maran theme
        sed -i -e 's/robbyrussell/maran/' /root/.zshrc  #set theme
        source .zshrc #reloading shell settings
fi
#Done
echo $(echo -e $GREEN"DONE"$RESET);
