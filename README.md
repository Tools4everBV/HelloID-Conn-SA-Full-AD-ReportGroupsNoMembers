# HelloID-Conn-SA-Full-AD-ReportGroupsNoMembers

| :information_source: Information |
|:---|
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements. |

## Description

HelloID-Conn-SA-Full-AD-ReportGroupsNoMembers is a delegated form designed for use with HelloID Service Automation (SA). It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can generate reports of Active Directory groups that have no members. The following options are available:

1. View an overview of AD Group objects that have no members (within the specified OUs).
2. Export the report data to a local CSV file on the HelloID Agent server (optional).

This form enables users to identify empty groups in Active Directory without requiring direct access to AD, thereby improving security by controlling access to the directory.

## Getting started

### Requirements

- **Active Directory Access**: The connector requires access to an Active Directory domain with sufficient permissions to query group information. A service account with appropriate AD read permissions is necessary.
- **HelloID Agent**: A HelloID Agent must be installed and configured to communicate with the Active Directory domain.
- **PowerShell module 'ActiveDirectory'**: The HelloID Agent must have PowerShell available with Active Directory module support.

### Connection settings

The following user-defined variables are used by the connector.

| Variable name | Example value | Description | Required |
| ------------- | ------------- | ----------- | -------- |
| ADGroupReportOU | `[{ "OU": "OU=Groups,DC=contoso,DC=local"}]` | Array of Active Directory OUs for scoping AD groups shown in this report | Yes |
| HIDreportFolder | `C:\HIDreports\` | Local folder on HelloID Agent server for exporting CSV reports | Yes |

## Remarks

### Group Search

- **Search Scope**: Groups are retrieved from the Active Directory OUs specified in the `ADGroupReportOU` variable.
- **Empty Group Detection**: The form identifies groups with zero members within the specified search scope.

### CSV Export

- **Optional Export**: Users can choose to export the report results to a CSV file on the HelloID Agent server.
- **Export Location**: The CSV file is saved to the directory specified in the `HIDreportFolder` variable.

## Development resources

### PowerShell Module

This connector uses the ActiveDirectory PowerShell module for querying Active Directory groups.

- [ActiveDirectory Module Documentation](https://learn.microsoft.com/en-us/powershell/module/activedirectory/)

### Cmdlets

The following PowerShell cmdlets are used by the connector:

| Cmdlet | Description |
| ------ | ----------- |
| Get-ADGroup | Retrieves Active Directory groups |

### Cmdlet documentation

- [Get-ADGroup](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adgroup)

## Getting help

| :memo: Note |
|:---|
| For more information on Delegated Forms, please refer to our [documentation pages](https://docs.helloid.com/en/service-automation/delegated-forms.html). |

## HelloID docs

The official HelloID documentation can be found at: [https://docs.helloid.com/](https://docs.helloid.com/)