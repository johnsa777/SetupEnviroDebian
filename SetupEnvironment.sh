#Shell to setup my environment
#This setup is appropriate for ephemeral sessions on google cloud services
#or new systems
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
if [ ! -f /root/.vimrc ]; then
        sudo touch /root/.vimrc
        sudo chmod 770 /root/.vimrc
        sudo echo 'syntax on' >> /root/.vimrc
fi
#get locate, nmap, vim
sudo apt-get install nmap locate vim -y
#get zsh and oh-my-zsh
sudo rm -r /root/.oh-my-zsh; echo '*** delete prev oh-my-zsh install if present'
sudo apt-get install zsh -y
sudo sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
#dowload Honukai theme and reloading shell
echo '*** setting template'
sed -i -e 's/robbyrussell/honukai/' /root/.zshrc  #set theme
source .zshrc #reloading shell settings
#TODO change root password
echo 'END OF SCRIPT'