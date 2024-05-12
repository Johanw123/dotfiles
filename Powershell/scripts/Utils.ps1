function Check-Modern-PS
{
    $version = (Get-Host).Version

    if([System.Version]$version -gt [System.Version]"6.0.0.0"){
        return $true
    }
    else{
        return $false
    }
}