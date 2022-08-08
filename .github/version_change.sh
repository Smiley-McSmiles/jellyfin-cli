#!/bin/bash
echo "Please enter the current version to change"
echo "EXAMPLE: 'v1.3.7'"
read currentVersion
echo
echo "Please enter the new version number"
echo "EXAMPLE: 'v1.4.0'"
read newVersion

sed -i -e "s|$currentVersion|$newVersion|g" ../README.md
sed -i -e "s|$currentVersion|$newVersion|g" ../jellyfin.1
sed -i -e "s|$currentVersion|$newVersion|g" ../scripts/jellyfin
