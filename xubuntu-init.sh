#!/bin/bash

# Update the list of available packages and their versions and install newer versions of the packages you have
sudo apt update
sudo apt upgrade

# Install the ISC DHCP client, which is used to obtain an IP address via DHCP
sudo apt install isc-dhcp-client

# Run the DHCP client to obtain an IP address
sudo dhclient

# Check the version of the DHCP client installed
dhclient --version

# Display network configuration
ifconfig

# Download Microsoft's GPG key and add it to the list of trusted keys for apt
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

# Add the Visual Studio Code repository to your system's software repository list
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# Update the list of packages again to include the newly added VS Code repository
sudo apt update

# Install Visual Studio Code
sudo apt install code

# Install Firefox
sudo apt install firefox

# Install Neofetch
sudo apt install neofetch 