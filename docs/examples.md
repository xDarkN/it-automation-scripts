# Script Examples and Learning Notes

This document explains what each script demonstrates from an IT automation and system administration perspective.

## 1. Windows Service Health Check

Script:

```text
scripts/windows-service-health-check.ps1
```

### What it does

Checks selected Windows services, reports whether each service exists, and shows its current status and startup type.

### Skills demonstrated

- PowerShell parameters
- Service monitoring with `Get-Service`
- Error handling with `try/catch`
- Working with custom objects
- Exporting reports to CSV
- Basic operational health checks

### Real-world use case

This type of script can help IT teams quickly verify that important services are running on a workstation or server.

---

## 2. Disk Space Report

Script:

```text
scripts/disk-space-report.ps1
```

### What it does

Scans local fixed drives and reports total space, used space, free space, free percentage and health status based on a warning threshold.

### Skills demonstrated

- WMI/CIM queries with `Get-CimInstance`
- Disk capacity calculations
- Threshold-based status logic
- CSV reporting
- Operational monitoring basics

### Real-world use case

This type of script can be used to identify low disk space before it causes system issues or service interruptions.

---

## 3. Basic System Info Report

Script:

```text
scripts/basic-system-info-report.ps1
```

### What it does

Collects basic system information such as computer name, logged-in user, OS version, uptime, CPU, RAM and IP addresses.

### Skills demonstrated

- Collecting system inventory data
- Using CIM classes
- Working with dates and uptime calculations
- Network information collection
- Structured reporting

### Real-world use case

This type of script can help with troubleshooting, documentation, asset review or quick system checks.

---

## 4. File Server Permissions Audit

Script:

```text
scripts/file-server-permissions-audit.ps1
```

### What it does

Audits NTFS permissions for a target folder and exports access control entries to a CSV report.

### Skills demonstrated

- NTFS permission review
- Working with `Get-Acl`
- Folder scanning
- Optional recursive scanning
- Access control documentation
- Security-aware reporting

### Real-world use case

This type of script can help document folder access, review permissions and support file server cleanup or security audits.

---

## 5. Inactive Local Users Report

Script:

```text
scripts/inactive-local-users-report.ps1
```

### What it does

Reports local Windows user accounts, whether they are enabled, when they last logged in and whether they appear inactive.

### Skills demonstrated

- Local user account reporting
- Inactivity threshold logic
- Working with dates
- Account review basics
- CSV export
- Security and hygiene checks

### Real-world use case

This type of script can help identify unused local accounts that may need review, disablement or cleanup.

---

## Portfolio Value

Together, these scripts demonstrate practical skills in:

- Windows administration
- PowerShell automation
- IT reporting
- Troubleshooting workflows
- Security-aware scripting
- CSV-based reporting
- Documentation
- Operational thinking

The scripts are intentionally simple and readable, making them useful for learning, portfolio demonstration and future improvement.