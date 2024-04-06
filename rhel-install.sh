#!/bin/bash

# Get version of RHEL
source /etc/os-release

# Determine major version
if (( $(bc <<< "$VERSION_ID < 8") == 1 )); then
    majorver=7
elif (( $(bc <<< "$VERSION_ID < 9") == 1 )); then
    majorver=8
else
    majorver=9
fi

# Register the Microsoft RedHat repository
curl -sSL -O https://packages.microsoft.com/config/rhel/$majorver/packages-microsoft-prod.rpm

# Register the Microsoft repository keys
if ! sudo rpm -i packages-microsoft-prod.rpm; then
    echo "Error installing repository keys. Exiting."
    exit 1
fi

# Delete the repository keys after installing
rm -f packages-microsoft-prod.rpm

# Update package index files and install PowerShell based on RHEL version
if (( $majorver < 8 )); then
    package_manager="yum"
else
    package_manager="dnf"
fi

# Update package index and install PowerShell
if ! sudo $package_manager update; then
    echo "Error updating package index. Exiting."
    exit 1
fi

if ! sudo $package_manager install powershell -y; then
    echo "Error installing PowerShell. Exiting."
    exit 1
fi

# To remove powershell from RHEL 7 {sudo yum remove powershell}
# To remove powershell from RHEL 8 and 9 {sudo dnf remove powershell}