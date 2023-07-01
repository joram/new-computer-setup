#!/usr/bin/env bash

# browsers
function install_chrome(){
  apt install libu2f-udev
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
}
while true; do
  read -p "Do you wish to install google chrome? (y/N)" yn
  case $yn in
    [Yy]* ) install_chrome; break;;
    [Nn]* ) break;;
    * ) break;;
  esac
done
