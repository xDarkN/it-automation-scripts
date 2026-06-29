<#
.SYNOPSIS
    Audits NTFS permissions for folders.

.DESCRIPTION
    This script scans a target folder and exports NTFS permission entries
    for the root folder and its immediate subfolders.

    It is useful for documenting folder access, reviewing permissions,
    and creating basic file server permission reports.

.NOTES
    Author: Nadav Edri
    Purpose: IT automation portfolio script
#>

param(
    [string]$Path = ".\demo-data\shared-folder",
    [string]$OutputPath = ".\output-samples\file-server-permissions-audit.csv",
    [switch]$Recurse
)

Write-Host "Starting File Server Permissions Audit..." -ForegroundColor Cyan
Write-Host "Target path: $Path"
Write-Host ""

if (-not (Test-Path $Path)) {
    Write-Host "Target path does not exist: $Path" -ForegroundColor Red
    exit 1
}

try {
    if ($Recurse) {
        $folders = Get-ChildItem -Path $Path -Directory -Recurse -ErrorAction Stop
    }
    else {
        $folders = Get-ChildItem -Path $Path -Directory -ErrorAction Stop
    }

    $folders = @((Get-Item -Path $Path -ErrorAction Stop)) + $folders

    $results = foreach ($folder in $folders) {
        try {
            $acl = Get-Acl -Path $folder.FullName -ErrorAction Stop

            foreach ($accessRule in $acl.Access) {
                [PSCustomObject]@{
                    ComputerName        = $env:COMPUTERNAME
                    FolderPath          = $folder.FullName
                    IdentityReference   = $accessRule.IdentityReference.ToString()
                    FileSystemRights    = $accessRule.FileSystemRights.ToString()
                    AccessControlType   = $accessRule.AccessControlType.ToString()
                    IsInherited         = $accessRule.IsInherited
                    InheritanceFlags    = $accessRule.InheritanceFlags.ToString()
                    PropagationFlags    = $accessRule.PropagationFlags.ToString()
                    Owner               = $acl.Owner
                    CheckedAt           = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                }
            }
        }
        catch {
            [PSCustomObject]@{
                ComputerName        = $env:COMPUTERNAME
                FolderPath          = $folder.FullName
                IdentityReference   = "ERROR"
                FileSystemRights    = "ERROR"
                AccessControlType   = "ERROR"
                IsInherited         = "ERROR"
                InheritanceFlags    = "ERROR"
                PropagationFlags    = "ERROR"
                Owner               = "ERROR"
                CheckedAt           = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            }
        }
    }

    $results | Format-Table FolderPath, IdentityReference, FileSystemRights, AccessControlType, IsInherited -AutoSize

    $outputDirectory = Split-Path -Path $OutputPath -Parent

    if (-not (Test-Path $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8

    Write-Host ""
    Write-Host "Report exported to: $OutputPath" -ForegroundColor Green
    Write-Host "File Server Permissions Audit completed." -ForegroundColor Cyan
}
catch {
    Write-Host "An error occurred while auditing permissions." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}