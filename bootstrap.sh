#!/bin/bash
if [ -d ~/.electrumx-installer ]; then
    echo "~/.electrumx-installer already exists."
    echo "Either delete the directory or run ~/.electrumx-installer/install.sh directly."
    exit 1
fi
if which git > /dev/null 2>&1; then
    git clone -b python38 https://github.com/spaceexpanse/electrumx-installer ~/.electrumx-installer
    cd ~/.electrumx-installer/
else
    which wget > /dev/null 2>&1 && which unzip > /dev/null 2>&1 || { echo "Please install git or wget and unzip" && exit 1 ; }
    wget https://github.com/spaceexpanse/electrumx-installer/archive/refs/heads/electrumx-installer-python38.zip -O /tmp/electrumx-installer-python38.zip
    unzip /tmp/electrumx-installer-python38.zip -d ~/.electrumx-installer
    rm /tmp/electrumx-installer-python38.zip
    cd ~/.electrumx-installer/electrumx-installer-python38/ 
fi
if [[ $EUID -ne 0 ]]; then
    which sudo > /dev/null 2>&1 || { echo "You need to run this script as root" && exit 1 ; }
    sudo -H ./install.sh "$@"
else
    ./install.sh "$@"
fi
