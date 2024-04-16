[int]$range = Read-Host "Enter the range of hostnames"
[string]$constantName = Read-Host "Enter the hostname constant"

New-Item -Path "hosts.txt" -ItemType "file"
if (!(Test-Path "hosts.txt")) {
    New-Item -Path "hosts$range.txt" -ItemType "file" -Force SilentContiue
}

for ([int]$i = 1; $i -le $range; $i++) {
    [string]$hostname = "$constantName$i"
    Write-Host "Pinging $realHost..."
    [int]$result = Test-Connection -ComputerName $hostname -Count 1 -Quiet

    [string]$ip = [System.Net.Dns]::GetHostAddresses($hostname).IPAddressToString
    Write-Host "O endereço IP é: $ip"

    if ($result) {
        Write-Host "$hostname is reachable."
        Add-Content -Path "hosts.txt" -Value "$hostname -" -Force
    } else {
        Write-Host "No response for $hostname."
    }
    Get-Content hosts.txt
}