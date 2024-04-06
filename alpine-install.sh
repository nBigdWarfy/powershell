#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Install requirements
sudo apk add --no-cache \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    curl

# Add additional repository and install lttng-ust package
sudo apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache lttng-ust

# Download PowerShell archive
echo "Downloading PowerShell..."
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.1/powershell-7.4.1-linux-musl-x64.tar.gz -o /tmp/powershell.tar.gz

# Verify download integrity (you'll need to obtain the correct checksum from PowerShell GitHub release page)
# if ! sha256sum -c <<< "expected_checksum /tmp/powershell.tar.gz"; then
#     echo "Checksum verification failed."
#     exit 1
# fi

# Create target folder for PowerShell
echo "Creating target folder for PowerShell..."
sudo mkdir -p /opt/microsoft/powershell/7

# Extract PowerShell to the target folder
echo "Extracting PowerShell..."
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions for PowerShell executable
echo "Setting execute permissions..."
sudo chmod +x /opt/microsoft/powershell/7/pwsh

# Create symbolic link for pwsh
echo "Creating symbolic link..."
sudo ln -sf /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

echo "PowerShell installation complete. You can now start PowerShell by typing 'pwsh'."

# To remove powershell from Alpine {sudo rm -rf /usr/bin/pwsh /opt/microsoft/powershell}