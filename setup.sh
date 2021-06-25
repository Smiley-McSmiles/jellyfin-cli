#!/bin/bash
DIRECTORY=$(cd `dirname $0` && pwd)

echo "Fetching newest Jellyfin version..."
wget https://repo.jellyfin.org/releases/server/linux/stable/combined/
jellyfin_archive=$(grep 'tar.gz"' index.html | cut -d '"' -f 2)
rm index.html
wget https://repo.jellyfin.org/releases/server/linux/stable/combined/$jellyfin_archive
jellyfin=$(echo $jellyfin_archive | sed -r 's/.tar.gz//g')
sudo adduser -rd /opt/jellyfin jellyfin
sudo mkdir /opt/jellyfin
sudo mkdir /opt/jellyfin/old
sudo cp -r update /opt/jellyfin/
sudo cp jellyfin-update /bin/
sudo cp $jellyfin_archive /opt/jellyfin/
sudo cp jellyfin.sh /opt/jellyfin/
sudo cp jellyfin.service /usr/lib/systemd/system/
sudo cp jellyfin.conf /etc/
cd /opt/jellyfin
sudo tar xvzf $jellyfin_archive
sudo ln -s $jellyfin jellyfin
sudo mkdir data cache config log

echo "Preparing to install needed dependancies for Jellyfin..."
echo
echo Please enter root password to install dependancies....

packagesNeeded='ffmpeg ffmpeg-devel ffmpeg-libs'
if [ -x "$(command -v apt)" ]; then
	sudo apt install $packagesNeeded
elif [ -x "$(command -v dnf)" ]; then 
	sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf install $packagesNeeded
else 
	echo "FAILED TO INSTALL PACKAGES: Package manager not found. You must manually install: ffmpeg";
fi

echo "Setting Permissions for Jellyfin..."
sudo chown -R jellyfin:jellyfin /opt/jellyfin
sudo chmod u+x jellyfin.sh
sudo chmod +x /bin/jellyfin-update
sudo chmod ug+x /opt/jellyfin/update/update.sh

echo "Unblocking port 8096..."
if [ -x "$(command -v ufw)" ]; then
	sudo ufw allow 8096
elif [ -x "$(command -v firewall-cmd)" ]; then 
	sudo firewall-cmd --permanent --zone=public --add-port=8096/tcp
	sudo firewall-cmd --permanent --zone=public --add-port=8096/udp
	sudo firewall-cmd --reload
else echo "FAILED TO OPEN PORT 8096! ERROR NO 'ufw' OR 'firewall-cmd' COMMAND FOUND!";
fi

echo "Enabling jellyfin.service..."
sudo systemctl enable --now jellyfin.service
sudo systemctl status jellyfin.service

echo "Navigate to https://localhost:8096/ in your Web Browser to claim your"
echo "Jellyfin server"
echo
echo "To manage Jellyfin please use 'sudo systemctl start|stop|restart|enable|disable jellyfin'"
echo
echo "To update Jellyfin, please use 'sudo jellyfin-update'"
