try {
    $filter = {-not (member -like "*")}
    $properties = "CanonicalName", "Name", "CN", "Description"
    
    $ous = $ADGroupReportOU | ConvertFrom-Json
    $result = foreach($item in $ous) {
        Get-ADGroup -Filter $filter -SearchBase $item.ou -Properties $properties
    }
    $resultCount = @($result).Count
    $result = $result | Sort-Object -Property Name
    
    HID-Write-Status -Message "Result count: $resultCount" -Event Information
    HID-Write-Summary -Message "Result count: $resultCount" -Event Information
    
    if($resultCount -gt 0){
        foreach($r in $result){
            $returnObject = @{CanonicalName=$r.CanonicalName; Name=$r.Name; CN=$r.CN; Description=$r.Description}
            Hid-Add-TaskResult -ResultValue $returnObject
        }
    } else {
        Hid-Add-TaskResult -ResultValue []
    }
    
} catch {
    HID-Write-Status -Message "Error generating report. Error: $($_.Exception.Message)" -Event Error
    HID-Write-Summary -Message "Error generating report" -Event Failed
    
    Hid-Add-TaskResult -ResultValue []
}