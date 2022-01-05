#!/usr/bin/env bash

git config --global user.email "john@oram.ca"
git config --global user.name "John Oram"

function setup_ssh() {
  ssh-keygen -t rsa -b 4096 -C "john@oram.ca"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
  sudo apt install xclip -y
  xclip -sel clip < ~/.ssh/id_rsa.pub
  while true; do
    echo "your ssh pub key is on your clipboard"
    echo "please go here, and add it: https://github.com/settings/keys"
    read -p "Have you setup the key? (y/N)" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) break;;
        * ) break;;
    esac
  done

}

while true; do
  read -p "Do you wish to setup an ssh key (for github)? (y/N)" yn
  case $yn in
    [Yy]* ) setup_ssh; break;;
    [Nn]* ) break;;
    * ) break;;
  esac
done