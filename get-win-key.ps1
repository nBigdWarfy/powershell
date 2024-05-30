# Function to decode the product key from the DigitalProductId
function Get-WindowsKey {
    # Retrieve the product key from the registry
    $key = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform').BackupProductKeyDefault
    if ($key) {
        # Return the product key if found
        return $key
    } else {
        # Output a message if the product key is not found
        Write-Output "Product key not found in BackupProductKeyDefault." -ForegroundColor Red
    }
}

# Call the function to get the Windows product key and store it in $ProductKey
$ProductKey = Get-WindowsKey
# Display the product key to the user
Write-Output "Your Windows Product Key is: $ProductKey"

# Execute the slmgr.vbs /dlv command and capture its output
$output = & slmgr.vbs /dlv

# Display the output of the slmgr.vbs /dlv command
Write-Output $output