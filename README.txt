Jellyfin Manager:
OPERATION:
-DESCRIPTION:
  jellyfin-manager is simply an install and update script for jellyfin, specifically for 
  the jellyfin_x.tar.gz files hosted at:https://repo.jellyfin.org/releases/server/linux/stable/combined/
-USAGE(LINUX):
  jellyfin-update
  jellyfin-uninstall

INSTALL(LINUX):
  git clone https://github.com/Smiley-McSmiles/jellyfin-manager
  cd jellyfin-manager
  chmod ug+x setup.sh
  ./setup.sh

UNINSTALL(LINUX):
  jellyfin-uninstall

Created by: Smiley McSmiles
