# Usage Guide

This document explains how to run the scripts in this repository.

## Windows Service Health Check

Script path:

```powershell
scripts/windows-service-health-check.ps1
```

Run from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows-service-health-check.ps1
```

The script checks selected Windows services and exports a CSV report to:

```text
output-samples/windows-service-health-check-report.csv
```

### Example with custom services

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows-service-health-check.ps1 -ServiceNames "Spooler","BITS","WinDefend"
```

### Example with custom output path

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows-service-health-check.ps1 -OutputPath ".\output-samples\custom-service-report.csv"
```

## Disk Space Report

Script path:

```powershell
scripts/disk-space-report.ps1
```

Run from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\disk-space-report.ps1
```

The script scans local fixed drives and exports a CSV report to:

```text
output-samples/disk-space-report.csv
```

### Example with custom warning threshold

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\disk-space-report.ps1 -WarningThresholdPercent 15
```

### Example with custom output path

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\disk-space-report.ps1 -OutputPath ".\output-samples\custom-disk-report.csv"
```