<#
.SYNOPSIS
    Checks the health status of important Windows services.

.DESCRIPTION
    This script checks whether selected Windows services exist and whether they are running.
    It outputs the results to the console and exports a CSV report.

.NOTES
    Author: Nadav Edri
    Purpose: IT automation portfolio script
#>

param(
    [string[]]$ServiceNames = @(
        "wuauserv",      # Windows Update
        "WinDefend",     # Microsoft Defender Antivirus
        "Spooler",       # Print Spooler
        "BITS",          # Background Intelligent Transfer Service
        "Dhcp",          # DHCP Client
        "Dnscache"       # DNS Client
    ),

    [string]$OutputPath = ".\output-samples\windows-service-health-check-report.csv"
)

Write-Host "Starting Windows Service Health Check..." -ForegroundColor Cyan
Write-Host ""

$results = foreach ($serviceName in $ServiceNames) {
    try {
        $service = Get-Service -Name $serviceName -ErrorAction Stop

        [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            ServiceName  = $service.Name
            DisplayName  = $service.DisplayName
            Status       = $service.Status
            StartType    = $service.StartType
            Found        = $true
            CheckedAt    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        }
    }
    catch {
        [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            ServiceName  = $serviceName
            DisplayName  = "N/A"
            Status       = "Missing"
            StartType    = "N/A"
            Found        = $false
            CheckedAt    = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        }
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
Write-Host "Windows Service Health Check completed." -ForegroundColor Cyan