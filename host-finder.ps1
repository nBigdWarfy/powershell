while($true) {
    # Prompt the user to enter the range of hostnames
    [int]$range = Read-Host "Enter the range of hostnames"

    # Prompt the user to enter the hostname constant
    [string]$constantName = Read-Host "Enter the hostname constant"

    # Create a new file named "hosts.txt" forcefully, if it doesn't exist already
    New-Item -Path "hosts.txt" -ItemType "file" -Force

    # Iterate over the range of hostnames
    for ($i = 1; $i -le $range; $i++) {
        # Construct the hostname by appending the constant name with the current index
        $hostname = "$constantName$i"

        # Display a message indicating pinging of the hostname
        Write-Host "Pinging $hostname..."

        # Ping the hostname and store the result
        $result = Test-Connection -ComputerName $hostname -Count 1 -Quiet

        try {
            # Get the IP address corresponding to the hostname
            $ip = [System.Net.Dns]::GetHostAddresses($hostname).IPAddressToString
        } catch {
            # If unable to retrieve the IP address, catch the exception and display an error message
            Write-Host "Error: $_"
        }

        # Display the IP address of the hostname
        Write-Host "$hostname IP address is: $ip"

        # Check if the hostname is reachable
        if ($result) {
            # Display a message indicating the hostname is reachable
            Write-Host "$hostname is reachable."

            # Append the hostname and its IP address to the "hosts.txt" file
            Add-Content -Path "hosts.txt" -Value "$hostname($ip)" -Force
        } else {
            # Display a message indicating no response for the hostname
            Write-Host "No response for $hostname."
        }
    }

    # Read the content of the "hosts.txt" file into the $computers variable
    $computers = Get-Content -Path hosts.txt

    # Iterate over and display each line in the "hosts.txt" file
    foreach ($computer in $computers) {
        Write-Host "Computer host: $computers"
    }

    # Prompt the user if they want to do another search
    [string]$repeat = Read-Host "Do another search? (Y/N)"

    # Check if the user wants to repeat the search
    if ($repeat -ne "Y") {
        break; # Exit the loop if the user does not want to repeat the search
    }
}