<#
.SYNOPSIS
    Collects basic system information from the local computer.

.DESCRIPTION
    This script collects useful system information such as computer name,
    logged-in user, operating system, uptime, CPU, memory and IP addresses.
    It outputs the results to the console and exports a CSV report.

.NOTES
    Author: Nadav Edri
    Purpose: IT automation portfolio script
#>

param(
    [string]$OutputPath = ".\output-samples\basic-system-info-report.csv"
)

Write-Host "Starting Basic System Info Report..." -ForegroundColor Cyan
Write-Host ""

try {
    $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
    $operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
    $processor = Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1

    $lastBootTime = $operatingSystem.LastBootUpTime
    $uptime = (Get-Date) - $lastBootTime

    $ipAddresses = Get-NetIPAddress -AddressFamily IPv4 |
        Where-Object {
            $_.IPAddress -notlike "127.*" -and
            $_.PrefixOrigin -ne "WellKnown"
        } |
        Select-Object -ExpandProperty IPAddress

    $result = [PSCustomObject]@{
        ComputerName       = $env:COMPUTERNAME
        LoggedInUser       = $env:USERNAME
        Domain             = $computerSystem.Domain
        Manufacturer       = $computerSystem.Manufacturer
        Model              = $computerSystem.Model
        OSName             = $operatingSystem.Caption
        OSVersion          = $operatingSystem.Version
        LastBootTime       = $lastBootTime.ToString("yyyy-MM-dd HH:mm:ss")
        UptimeDays         = [math]::Round($uptime.TotalDays, 2)
        CPU                = $processor.Name
        TotalRAMGB         = [math]::Round($computerSystem.TotalPhysicalMemory / 1GB, 2)
        IPAddresses        = ($ipAddresses -join ", ")
        CheckedAt          = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    }

    $result | Format-List

    $outputDirectory = Split-Path -Path $OutputPath -Parent

    if (-not (Test-Path $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    $result | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8

    Write-Host ""
    Write-Host "Report exported to: $OutputPath" -ForegroundColor Green
    Write-Host "Basic System Info Report completed." -ForegroundColor Cyan
}
catch {
    Write-Host "An error occurred while collecting system information." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}