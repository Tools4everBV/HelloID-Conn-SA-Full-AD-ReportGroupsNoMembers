try {
    $filter = {-not (member -like "*")}
    $properties = "CanonicalName", "Name", "CN", "Description"
    
    $ous = $ADGroupReportOU | ConvertFrom-Json
    $result = foreach($item in $ous) {
        Get-ADGroup -Filter $filter -SearchBase $item.ou -Properties $properties
    }
    $resultCount = @($result).Count
    $result = $result | Sort-Object -Property Name
    
    Write-information "Result count: $resultCount"
    
    if($resultCount -gt 0){
        foreach($r in $result){
            $returnObject = @{CanonicalName=$r.CanonicalName; Name=$r.Name; CN=$r.CN; Description=$r.Description}
            Write-output $returnObject
        }
    } else {
        return
    }
    
} catch {
    write-error "Error generating report. Error: $($_.Exception.Message)"
    return
}
