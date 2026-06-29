<#
.SYNOPSIS
    Generates a report of local user accounts and inactivity status.

.DESCRIPTION
    This script checks local Windows user accounts and reports account status,
    last logon time and whether the account appears inactive based on a defined
    number of days.

    It exports the results to a CSV file.

.NOTES
    Author: Nadav Edri
    Purpose: IT automation portfolio script
#>

param(
    [int]$InactiveDays = 90,
    [string]$OutputPath = ".\output-samples\inactive-local-users-report.csv"
)

Write-Host "Starting Inactive Local Users Report..." -ForegroundColor Cyan
Write-Host "Inactive threshold: $InactiveDays days"
Write-Host ""

try {
    $cutoffDate = (Get-Date).AddDays(-$InactiveDays)

    $users = Get-LocalUser

    $results = foreach ($user in $users) {
        $lastLogon = $user.LastLogon

        if ($null -eq $lastLogon) {
            $inactiveStatus = "Never Logged In"
            $daysSinceLastLogon = "N/A"
        }
        else {
            $daysSinceLastLogon = [math]::Round(((Get-Date) - $lastLogon).TotalDays, 0)

            if ($lastLogon -lt $cutoffDate) {
                $inactiveStatus = "Inactive"
            }
            else {
                $inactiveStatus = "Active"
            }
        }

        [PSCustomObject]@{
            ComputerName        = $env:COMPUTERNAME
            UserName            = $user.Name
            FullName            = $user.FullName
            Enabled             = $user.Enabled
            LastLogon           = if ($lastLogon) { $lastLogon.ToString("yyyy-MM-dd HH:mm:ss") } else { "Never" }
            DaysSinceLastLogon  = $daysSinceLastLogon
            InactiveThreshold   = "$InactiveDays days"
            InactivityStatus    = $inactiveStatus
            CheckedAt           = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        }
    }

    $results | Format-Table UserName, Enabled, LastLogon, DaysSinceLastLogon, InactivityStatus -AutoSize

    $outputDirectory = Split-Path -Path $OutputPath -Parent

    if (-not (Test-Path $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8

    Write-Host ""
    Write-Host "Report exported to: $OutputPath" -ForegroundColor Green
    Write-Host "Inactive Local Users Report completed." -ForegroundColor Cyan
}
catch {
    Write-Host "An error occurred while generating the local users report." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}