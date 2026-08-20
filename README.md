# HelloID-Conn-SA-Full-AD-ReportGroupsNoMembers

| :information_source: Information |
|:---|
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements. |

## Description

HelloID-Conn-SA-Full-AD-ReportGroupsNoMembers is a delegated form designed for use with HelloID Service Automation (SA). It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can generate a report of Active Directory groups that have no members. The following options are available:

1. View an overview of AD group objects that have no members (within the specified OUs).
2. View basic AD group attributes (ObjectGuid, CanonicalName, Name, and Description).
3. Optionally download the results directly from the HelloID interface using the built-in download functionality.

This form enables users to identify empty groups in Active Directory without requiring direct access to AD, thereby improving security by controlling access to the directory.

## Getting started

### Requirements

- **Active Directory Access**: The connector requires read access to an Active Directory domain. A service account with appropriate AD read permissions is necessary.
- **HelloID Agent**: A HelloID Agent must be installed and configured to communicate with the Active Directory domain.
- **PowerShell module 'ActiveDirectory'**: The HelloID Agent must have PowerShell available with Active Directory module support.

### Connection settings

The following user-defined variables are used by the connector.

| Variable name | Example value | Description | Required |
| ------------- | ------------- | ----------- | -------- |
| AdGroupsReportSearchOu | `OU=Groups,DC=contoso,DC=local;OU=Distribution,DC=contoso,DC=local` | Semicolon-separated list of Active Directory OUs for scoping AD groups in the report | Yes |

## Remarks

### Group Search

- **Search Scope**: The search is limited to the OUs defined in the `AdGroupsReportSearchOu` variable. Multiple OUs can be specified using semicolon separation.
- **Empty Group Detection**: The connector uses the filter `-not(member -like '*')` to identify groups without any members.

### Report Output

- **Fixed Properties**: The report always includes ObjectGuid, CanonicalName, Name, and Description.
- **Sorting**: Results are sorted by Name for easier review.

## Development resources

### PowerShell Module

This connector uses the ActiveDirectory PowerShell module for querying Active Directory groups.

- [ActiveDirectory Module Documentation](https://learn.microsoft.com/en-us/powershell/module/activedirectory/)

### Cmdlets

The following PowerShell cmdlets are used by the connector:

| Cmdlet | Description |
| ------ | ----------- |
| Get-ADGroup | Retrieves Active Directory groups |
Forest | Retrieves Active Directory forest information |
| Get-ADDomain | Retrieves Active Directory domain information |
| Get-ADGroup | Retrieves Active Directory groups |

### Cmdlet documentation

- [Get-ADForest](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adforest)
- [Get-ADDomain](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-addomain)- [Get-ADGroup](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adgroup)

## Getting help

| :memo: Note |
|:---|
| For more information on Delegated Forms, please refer to our [documentation pages](https://docs.helloid.com/en/service-automation/delegated-forms.html). |

## HelloID docs

The official HelloID documentation can be found at: [https://docs.helloid.com/](https://docs.helloid.com/)