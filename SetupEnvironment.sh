#Shell to setup my environment
#This setup is appropriate for ephemeral sessions on google cloud services
#or new systems
#update system

#Change system password
while true; do
    read -p "Would you like to change your password? (y/n)" yn
    case $yn in
        [Yy]* ) passwd; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

#Redo ssh keys
while true; do
    read -p "Would you like to regenerate your ssh keys (y/n)" yn
    case $yn in
        [Yy]* ) sudo ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 52
1 -y; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

#Remove identification banner
sudo rm /etc/issue
sudo rm /etc/motd

#update system
apt-get update -y
apt-get upgrade -y

#setup cron job to update system
#write out current crontab
if !(crontab -l | grep -q 'apt-get update'); then
        crontab -l > mycron
        #echo new cron into cron file
        echo "08 04 * * * apt-get update;apt-get upgrade;" >> mycron
        #install new cron file
        crontab mycron
        rm mycron
fi

#Turn color n on in vim if there are no vim settings
if [ cat /root/.vimrc | grep -q 'syntax on' ]
then
        echo 'vim settings present'
else
        sudo touch /root/.vimrc
        sudo chmod 770 /root/.vimrc
        sudo echo "syntax on" >> /root/.vimrc
fi

#get locate, nmap, vim
sudo apt-get install nmap locate vim -y

#get zsh and oh-my-zsh
if [ -e /root/.oh-my-zsh ]
then
        echo 'zsh present'
else
        sudo apt-get install zsh -y
        sudo sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh
/master/tools/install.sh -O -)"
        #dowload Honukai theme and reloading shell
        sed -i -e 's/robbyrussell/honukai/' /root/.zshrc  #set theme
        source .zshrc #reloading shell settings
fi
echo 'END OF SCRIPT'