#!/bin/bash
cd /opt/jellyfin/update

echo "Fetching newest Jellyfin version..."
wget https://repo.jellyfin.org/releases/server/linux/stable/combined/
jellyfin_archive=$(grep 'tar.gz"' index.html | cut -d '"' -f 2)
jellyfin=$(echo $jellyfin_archive | sed -r 's/.tar.gz//g')
new_jellyfin_version=$(echo $jellyfin | sed -r 's/jellyfin_//g')
rm index.html
wget https://repo.jellyfin.org/releases/server/linux/stable/combined/$jellyfin_archive

echo "Unpacking $jellyfin_archive to /opt/jellyfin/..."
sudo tar xvzf $jellyfin_archive /opt/jellyfin/
sudo systemctl stop jellyfin.service
sudo unlink /opt/jellyfin/jellyfin
sudo ln -s /opt/jellyfin/$jellyfin /opt/jellyfin/jellyfin
echo "moving $jellyfin_archive to /opt/jellyfin/old/$jellyfin_archive"
sudo mv -v /opt/jellyfin/update/$jellyfin_archive /opt/jellyfin/old/

sudo chown -R jellyfin:jellyfin /opt/jellyfin
echo "Jellyfin updated to version $new_jellyfin_version"
sudo systemctl start jellyfin.service
sudo systemctl status jellyfin.service
