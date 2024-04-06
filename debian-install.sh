#!/bin/bash

# Update the list of packages
sudo apt update

# Install pre-requisite packages.
sudo apt install -y wget apt-transport-https software-properties-common

# Get the version of Ubuntu
source /etc/os-release

# Check if the Ubuntu version is obtained successfully
if [ -z "$$VERSION_ID" ]; then
    echo "Failed to determine Ubuntu version."
    exit 1
fi

# Download the Microsoft repository keys
MICROSOFT_KEY_URL="https://packages.microsoft.com/config/ubuntu/$UBUNTU_VERSION/packages-microsoft-prod.deb"
wget -q "$MICROSOFT_KEY_URL" || { 
    echo "Failed to download Microsoft repository keys.";
    exit 1;
}

# Register the Microsoft repository keys
sudo dpkg -i packages-microsoft-prod.deb || {
    echo "Failed to register Microsoft repository keys.";
    exit 1; 
}

# Clean up the downloaded file
rm packages-microsoft-prod.deb

# Update the list of packages after adding packages.microsoft.com
sudo apt update

# Install PowerShell
sudo apt install -y powershell || {
    echo "Failed to install PowerShell.";
    exit 1;
}

echo "PowerShell has been installed successfully."

# To remove powershell from Debian {sudo apt-get remove powershell}