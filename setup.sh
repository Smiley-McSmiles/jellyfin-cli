#!/bin/bash
DIRECTORY=$(cd `dirname $0` && pwd)

has_sudo_access=""

`timeout -k .1 .1 bash -c "sudo /bin/chmod --help" >&/dev/null 2>&1` >/dev/null 2>&1
if [ $? -eq 0 ];then
   has_sudo_access="YES"
	echo "Hey $USER! My old friend..."
	sleep 2
else
   has_sudo_access="NO"
	echo "$USER, you're not using sudo..."
	echo "Please use 'sudo ./setup.sh' to install the scripts."
	exit
fi

echo "Fetching newest Jellyfin version..."
wget https://repo.jellyfin.org/releases/server/linux/stable/combined/
jellyfin_archive=$(grep 'tar.gz"' index.html | cut -d '"' -f 2)
rm index.html
wget https://repo.jellyfin.org/releases/server/linux/stable/combined/$jellyfin_archive
jellyfin=$(echo $jellyfin_archive | sed -r 's/.tar.gz//g')


mkdir /opt/jellyfin
clear

read -p "Please enter the default user for Jellyfin: " defaultUser
adduser -rd /opt/jellyfin $defaultUser
while id "$defaultUser" &>/dev/null; do
   echo "Cannot create $defaultUser as $defaultUser already exists..."
   read -p "Please re-enter a new default user for Jellyfin: " defaultUser
done

mkdir /opt/jellyfin/old
mkdir /opt/jellyfin/update
cp scripts/jellyfin /bin/
cp scripts/jellyfin.sh /opt/jellyfin/
cp $jellyfin_archive /opt/jellyfin/
cp conf/jellyfin.service /usr/lib/systemd/system/
cp conf/jellyfin.conf /etc/
cd /opt/jellyfin
tar xvzf $jellyfin_archive
ln -s $jellyfin jellyfin
mkdir data cache config log
touch config/jellyfin.conf
echo "defaultPath=" >> config/jellyfin.conf
echo "defaultUser=$defaultUser" >> config/jellyfin.conf

echo "Preparing to install needed dependancies for Jellyfin..."
echo
echo Please enter root password to install dependancies....

packagesNeeded='ffmpeg ffmpeg-devel ffmpeg-libs'
if [ -x "$(command -v apt)" ]; then
	apt install $packagesNeeded
elif [ -x "$(command -v dnf)" ]; then 
	dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	dnf install $packagesNeeded
else 
	echo "FAILED TO INSTALL PACKAGES: Package manager not found. You must manually install: ffmpeg";
fi

echo "Setting Permissions for Jellyfin..."
chown -R $defaultUser:$defaultUser /opt/jellyfin
chmod u+x jellyfin.sh
chmod +x /bin/jellyfin

echo "Unblocking port 8096..."
if [ -x "$(command -v ufw)" ]; then
	ufw allow 8096
elif [ -x "$(command -v firewall-cmd)" ]; then 
	firewall-cmd --permanent --zone=public --add-port=8096/tcp
	firewall-cmd --permanent --zone=public --add-port=8096/udp
	firewall-cmd --reload
else echo "FAILED TO OPEN PORT 8096! ERROR NO 'ufw' OR 'firewall-cmd' COMMAND FOUND!";
fi

echo "Enabling jellyfin.service..."
systemctl enable --now jellyfin.service
systemctl status jellyfin.service
echo

echo "Removing git cloned directory:$DIRECTORY..."
rm -rf $DIRECTORY
echo

echo
echo "DONE"
echo
echo "Navigate to https://localhost:8096/ in your Web Browser to claim your"
echo "Jellyfin server"
echo
echo "To manage Jellyfin use 'sudo systemctl start|stop|restart|enable|disable jellyfin'"
echo "or see 'jellyfin -h'"
echo
echo "To update Jellyfin, use 'sudo jellyfin -u'"
