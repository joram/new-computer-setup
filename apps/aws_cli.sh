#!/usr/bin/env bash

function install_aws_cli(){
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
}

while true; do
  read -p "Do you wish to setup the aws cli? (y/N)" yn
  case $yn in
    [Yy]* ) install_aws_cli; break;;
    [Nn]* ) break;;
    * ) break;;
  esac
done

