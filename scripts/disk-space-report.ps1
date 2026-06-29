<#
.SYNOPSIS
    Generates a disk space usage report for local drives.

.DESCRIPTION
    This script checks local fixed drives and reports total size, free space,
    used space and free space percentage. It exports the results to a CSV file.

.NOTES
    Author: Nadav Edri
    Purpose: IT automation portfolio script
#>

param(
    [int]$WarningThresholdPercent = 20,
    [string]$OutputPath = ".\output-samples\disk-space-report.csv"
)

Write-Host "Starting Disk Space Report..." -ForegroundColor Cyan
Write-Host ""

$drives = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType = 3"

$results = foreach ($drive in $drives) {
    $totalGB = [math]::Round($drive.Size / 1GB, 2)
    $freeGB  = [math]::Round($drive.FreeSpace / 1GB, 2)
    $usedGB  = [math]::Round(($drive.Size - $drive.FreeSpace) / 1GB, 2)

    if ($drive.Size -gt 0) {
        $freePercent = [math]::Round(($drive.FreeSpace / $drive.Size) * 100, 2)
    }
    else {
        $freePercent = 0
    }

    $status = if ($freePercent -lt $WarningThresholdPercent) {
        "Warning"
    }
    else {
        "Healthy"
    }

    [PSCustomObject]@{
        ComputerName     = $env:COMPUTERNAME
        DriveLetter      = $drive.DeviceID
        VolumeName       = $drive.VolumeName
        TotalGB          = $totalGB
        UsedGB           = $usedGB
        FreeGB           = $freeGB
        FreePercent      = $freePercent
        Status           = $status
        WarningThreshold = "$WarningThresholdPercent%"
        CheckedAt        = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    }
}

$results | Format-Table -AutoSize

$outputDirectory = Split-Path -Path $OutputPath -Parent

if (-not (Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
}

$results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8

Write-Host ""
Write-Host "Report exported to: $OutputPath" -ForegroundColor Green
Write-Host "Disk Space Report completed." -ForegroundColor Cyan