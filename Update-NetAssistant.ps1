param(
    [string]$NewVersion
)

# Check parameters
if (-not $NewVersion) {
    $NewVersion = Read-Host "Enter new version number (e.g.: 0.3.0)"
    if (-not $NewVersion) {
        Write-Host "Error: Version number cannot be empty" -ForegroundColor Red
        exit 1
    }
}

# Configuration
$PackageId = "SunJary.NetAssistant"
$DownloadUrl = "https://github.com/SunJary/NetAssistant/releases/download/v$NewVersion/netassistant-windows-x86_64.zip"

Write-Host "Updating $PackageId to version $NewVersion" -ForegroundColor Green
Write-Host "Download URL: $DownloadUrl" -ForegroundColor Cyan

# Run wingetcreate update
Write-Host "`nRunning wingetcreate update..." -ForegroundColor Yellow
try {
    $command = "wingetcreate update $PackageId --version $NewVersion --urls $DownloadUrl --submit"
    Write-Host "Command: $command" -ForegroundColor Gray
    
    # Execute the command
    Invoke-Expression $command
    
    Write-Host "`n✓ Update completed successfully!" -ForegroundColor Green
    Write-Host "The package has been updated and submitted." -ForegroundColor Green
}
catch {
    Write-Host "`n✗ Error: $_.Exception.Message" -ForegroundColor Red
    exit 1
}