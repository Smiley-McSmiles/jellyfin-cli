![jellyfin-cli](.github/banner-light.png?raw=true "Jellyfin Logo")
======

> v-1.0 Distributed CLI tool for Jellyfin tar.gz instller

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
* **Uninstall** - Uninstalls Jellyfin completely (Ignores the Media Directory).

### Getting Started

```shell
git clone https://github.com/Smiley-McSmiles/jellyfin-cli
cd jellyfin-cli
chmod ug+x setup.sh
sudo ./setup.sh
```

## Usage

   jellyfin - The CLI Tool
   -Created by Smiley McSmiles

   Syntax: jellyfin [b|d|e|h|p|r|s|S|u|X] [OPTIONS]
   options:
   -b     [DIRECTORY] Input directory to output backup archive
   -d     Disable jellyfin.service
   -e     Enable jellyfin.service
   -h     Print this Help
   -p     Reset the permissions of Jellyfin's Media Library
   -r     Restart jellyfin.service
   -s     Start jellyfin.service
   -S     Stop jellyfin.service
   -t     Status of jellyfin.service
   -u     Update Jellyfin
   -X     Uninstall Jellyfin Completely

### License
   This project is licensed under the [GPL V3.0 License](https://github.com/Smiley-McSmiles/jellyfin-cli/blob/main/LICENSE).
