## Available Scripts

### 1. Windows Service Health Check

Checks selected Windows services and reports whether they are running, stopped or missing.

Script:

```text
scripts/windows-service-health-check.ps1
```

### 2. Disk Space Report

Scans local fixed drives and generates a disk usage report including total space, used space, free space and health status.

Script:

```text
scripts/disk-space-report.ps1
```

### 3. Basic System Info Report

Collects basic system information such as hostname, logged-in user, OS version, uptime, CPU, RAM and IP addresses.

Script:

```text
scripts/basic-system-info-report.ps1
```

### 4. File Server Permissions Audit

Audits NTFS permissions for a target folder and exports access control entries for documentation and review.

Script:

```text
scripts/file-server-permissions-audit.ps1
```

### 5. Inactive Local Users Report

Reports local Windows user accounts, last logon information and inactivity status based on a configurable threshold.

Script:

```text
scripts/inactive-local-users-report.ps1
```