#!/usr/bin/env bash

# Add the apt repository:
echo "deb http://pkg.scaleft.com/deb linux main" | sudo tee -a /etc/apt/sources.list

# Trust the repository signing key:
curl -C - https://dist.scaleft.com/pki/scaleft_deb_key.asc | sudo apt-key add -

# Update the list of available packages:
sudo apt-get update

# Install the client:
sudo apt-get install scaleft-client-tools

# Install the URL handler:
sudo apt-get install scaleft-url-handler

sft enroll --team certn