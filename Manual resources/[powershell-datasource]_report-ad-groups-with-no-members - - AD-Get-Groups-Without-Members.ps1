#######################################################################
# Template: HelloID SA Powershell data source
# Name: report-ad-groups-without-members | AD-Get-Groups-Without-Members
# Date: 18-08-2026
#######################################################################

# For basic information about powershell data sources see:
# https://docs.helloid.com/en/service-automation/dynamic-forms/data-sources/powershell-data-sources.html

# Service automation variables:
# https://docs.helloid.com/en/service-automation/service-automation-variables.html

# Global variables (Automation --> Variable library)
$searchOUs = $AdGroupsReportSearchOu

# Fixed values
$propertiesToSelect = @(
    "ObjectGuid",
    "CanonicalName",
    "Name",
    "Description"
)

# Set debug logging
$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

try {
    #region Get Primary Domain Controller
    $actionMessage = "querying Primary Domain Controller"
    
    $domainController = (Get-ADForest | Select-Object -ExpandProperty RootDomain | Get-ADDomain | Select-Object -Property PDCEmulator).PDCEmulator
    Write-Information "Queried Primary Domain Controller: [$domainController]"
    #endregion Get Primary Domain Controller

    # Build filter to find groups without members
    $filter = "-not(member -like '*')"

    # Query groups
    $actionMessage = "querying AD group(s) matching the filter [$filter] in OU(s) [$($searchOUs)]"

    $ous = $searchOUs -split ';'
    $adGroups = [System.Collections.ArrayList]@()
    foreach ($ou in $ous) {
        $actionMessage = "querying AD group(s) matching the filter [$filter] in OU [$($ou)]"
        $getAdGroupsSplatParams = @{
            Filter      = $filter
            SearchBase  = $ou
            Properties  = $propertiesToSelect
            Server      = $domainController
            Verbose     = $False
            ErrorAction = "Stop"
        }
        $getAdGroupsResponse = Get-ADGroup @getAdGroupsSplatParams | Select-Object -Property $propertiesToSelect

        if ($getAdGroupsResponse -is [array]) {
            [void]$adGroups.AddRange($getAdGroupsResponse)
        }
        else {
            [void]$adGroups.Add($getAdGroupsResponse)
        }
    }
    Write-Information "Queried AD group(s) matching the filter [$filter] in OU(s) [$($searchOUs)]. Result count: $(($adGroups | Measure-Object).Count)"
    
    # Sort results by Name
    $actionMessage = "sorting results by Name"
    $adGroups = $adGroups | Sort-Object -Property Name
    
    # Send results to HelloID
    $adGroups | ForEach-Object {
        Write-Output $_
    }
}
catch {
    $ex = $PSItem
    Write-Warning "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"
    Write-Error "Error $($actionMessage). Error: $($ex.Exception.Message)"
    # exit # use when using multiple try/catch and the script must stop
}
