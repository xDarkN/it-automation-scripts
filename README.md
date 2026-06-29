# IT Automation Scripts

Practical PowerShell automation scripts for Windows administration, troubleshooting, reporting and operational workflows.

This repository is part of my professional portfolio as I continue developing skills in system administration, automation, DevOps workflows and AI-assisted technical problem solving.

## Purpose

The goal of this repository is to document and build useful IT automation scripts that can help with common administrative tasks such as system checks, reporting, user audits, file server reviews and operational troubleshooting.

The scripts are designed to be simple, readable and practical for real IT environments.

## Current Status

Version 1 of this repository includes five practical PowerShell scripts for Windows administration, reporting and operational troubleshooting.

The repository includes working scripts, usage documentation, learning notes, demo data and sanitized output samples.

## Focus Areas

* Windows administration
* PowerShell automation
* System health checks
* Local user account reporting
* File server and permissions review
* Infrastructure troubleshooting
* Operational reporting
* Security-aware scripting
* AI-assisted script development and refinement

## Available Scripts

### 1. Windows Service Health Check

Checks selected Windows services and reports whether they are running, stopped or missing.

Script:

```text
scripts/windows-service-health-check.ps1
```

### 2. Disk Space Report

Scans local fixed drives and generates a disk usage report including total space, used space, free space percentage and health status.

Script:

```text
scripts/disk-space-report.ps1
```

### 3. Basic System Info Report

Collects basic system information such as computer name, logged-in user, domain, OS version, uptime, CPU, RAM and IP addresses.

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

## Repository Structure

```text
scripts/          PowerShell automation scripts
docs/             Usage guide, examples and learning notes
output-samples/   Sanitized example CSV outputs
demo-data/        Demo folder structure for safe testing
```

## Documentation

* [Usage Guide](docs/usage.md)
* [Script Examples and Learning Notes](docs/examples.md)

## Security and Privacy

This repository uses sanitized sample data only.

Output samples should not include real company names, domains, internal computer names, usernames, IP addresses, production paths, credentials or sensitive information.

Before committing any new output files, sample data should be reviewed and sanitized.

## Notes

These scripts are built for learning, documentation and portfolio purposes.

They do not include credentials, private company data, production secrets or sensitive internal information.

## Learning Goals

Through this repository, I am improving my ability to:

* Write and understand practical PowerShell scripts
* Automate repetitive IT tasks
* Work with CSV outputs
* Add basic error handling
* Document technical workflows clearly
* Build a public technical portfolio
* Think about operational safety and data privacy

## Portfolio Value

This repository demonstrates practical skills in:

* PowerShell scripting
* Windows system administration
* IT automation
* Troubleshooting workflows
* CSV-based reporting
* NTFS permissions review
* Local account hygiene checks
* Documentation and structured technical communication

## Author

Nadav Edri
System Administrator focused on automation, DevOps workflows and AI-assisted technical projects.

LinkedIn: https://www.linkedin.com/in/nadav-edri1372/
GitHub: https://github.com/xDarkN
