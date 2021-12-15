![jellyfin-cli](.github/banner-light.png?raw=true "Jellyfin Logo")
======

> v-1.2 Distributed CLI tool for Jellyfin tar.gz installer (Only Tested on Fedora 34)

### Features

* **Setup** - Sets up the initial install.
* **Update** - Downloads and updates the current Jellyfin version.
* **Disable** - Disable the jellyfin.service.
* **Enable** - Enable the jellyfin.service
* **Start** - Start the jellyfin.service.
* **Stop** - Stop the jellyfin.service.
* **Restart** - Restart the jellyfin.service.
* **Status** - Get status information on jellyfin.service.
* **Backup** - Input a directroy to output the backup archive.
* **Import** - Import a .tar file to pick up where you left off on another system
* **Uninstall** - Uninstalls Jellyfin completely (Ignores the Media Directory).

### Getting Started

```shell
git clone https://github.com/Smiley-McSmiles/jellyfin-cli
cd jellyfin-cli
chmod ug+x setup.sh
sudo ./setup.sh
```

## Usage

```shell
jellyfin - The CLI Tool
-Created by Smiley McSmiles

Syntax: jellyfin -[b|d|e|h|i|p|r|s|S|u|X] [OPTIONS]
options:
-b     [DIRECTORY] Input directory to output backup archive
-d     Disable Jellyfin on System Start
-e     Enable Jellyfin on System Start
-h     Print this Help
-i     [FILE.tar] Input file to Import jellyfin-backup.tar
-p     Reset the permissions of Jellyfin's Media Library
-r     Restart Jellyfin
-s     Start Jellyfin
-S     Stop Jellyfin
-t     Status of Jellyfin
-u     Update Jellyfin
-X     Uninstall Jellyfin Completely
```

### License

   This project is licensed under the [GPL V3.0 License](https://github.com/Smiley-McSmiles/jellyfin-cli/blob/main/LICENSE).

