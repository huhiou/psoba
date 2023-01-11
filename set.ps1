# Disable firewall
try {
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
} catch {
    Write-Error "Error disabling firewall: $($_.Exception.Message)"
}

# Download and install Chrome Remote Desktop Host
$url = 'https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi'
$filePath = "$env:TEMP\chromeremotedesktophost.msi"
try {
    Invoke-WebRequest $url -OutFile $filePath
    Start-Process $filePath -Wait -WindowStyle Hidden
    Remove-Item $filePath
} catch {
    Write-Error "Error installing Chrome Remote Desktop Host: $($_.Exception.Message)"
}

# Download and install Google Chrome
$url = 'https://dl.google.com/chrome/install/latest/chrome_installer.exe'
$filePath = "$env:TEMP\chrome_installer.exe"
try {
    Invoke-WebRequest $url -OutFile $filePath
    Start-Process -FilePath $filePath -ArgumentList '/install' -Verb RunAs -Wait -WindowStyle Hidden
    Remove-Item $filePath
} catch {
    Write-Error "Error installing Google Chrome: $($_.Exception.Message)"
}
