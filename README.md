<!-- Description -->
## Description
This HelloID Service Automation Delegated Form provides an Active Directory report containing the Group objects that have no members. The following options are available:
 1. Overview of AD Group objects that match this report
 2. Export data to a local CSV file on the HelloID Agent server (optional)



## Versioning
| Version | Description | Date |
| - | - | - |
| 1.0.2   | Added version number and updated code for SA-agent and auditlogging | 2022/08/03  |
| 1.0.1   | Added version number and updated all-in-one script | 2021/11/03  |
| 1.0.0   | Initial release | 2020/11/24  |

<!-- TABLE OF CONTENTS -->
## Table of Contents
* [Description](#description)
* [All-in-one PowerShell setup script](#all-in-one-powershell-setup-script)
  * [Getting started](#getting-started)
* [Post-setup configuration](#post-setup-configuration)
* [Manual resources](#manual-resources)
* [Getting help](#getting-help)


## All-in-one PowerShell setup script
The PowerShell script "createform.ps1" contains a complete PowerShell script using the HelloID API to create the complete Form including user defined variables, tasks and data sources.

_Please note that this script asumes none of the required resources do exists within HelloID. The script does not contain versioning or source control_

### Getting started
Please follow the documentation steps on [HelloID Docs](https://docs.helloid.com/hc/en-us/articles/360017556559-Service-automation-GitHub-resources) in order to setup and run the All-in one Powershell Script in your own environment.


## Post-setup configuration
After the all-in-one PowerShell script has run and created all the required resources. The following items need to be configured according to your own environment
 1. Update the following [user defined variables](https://docs.helloid.com/hc/en-us/articles/360014169933-How-to-Create-and-Manage-User-Defined-Variables)
<table>
  <tr><td><strong>Variable name</strong></td><td><strong>Example value</strong></td><td><strong>Description</strong></td></tr>
  <tr><td>HIDreportFolder</td><td>C:\HIDreports\</td><td>Local folder on HelloID Agent server for exporting CSV reports</td></tr>
  <tr><td>ADGroupReportOU</td><td>[{ "OU": "OU=HelloIDCreated,OU=Groups,OU=Enyoi,DC=enyoi-media,DC=local"}]</td><td>Array of Active Directory OUs for scoping shown AD Group objects in this report</td></tr>
</table>

## Manual resources
This Delegated Form uses the following resources in order to run

### Powershell data source 'AD-group-generate-table-report-empty-groups'
This Powershell data source runs an Active Directory query to select the AD groups that match this report. It uses an array of Active Directory OU's specified as HelloID user defined variable named _"ADGroupReportOU"_ to specify the report scoping.

### Delegated form task 'AD - Report - Groups with no members'
This delegated form task runs the same Active Directory query as the task data source (AD query is defined at two places) and export the data to a local CSV file if selected in the form.

## Getting help
_If you need help, feel free to ask questions on our [forum](https://forum.helloid.com/forum/helloid-connectors/service-automation/516-helloid-sa-active-directory-report-ad-groups-with-no-members)_

## HelloID Docs
The official HelloID documentation can be found at: https://docs.helloid.com/