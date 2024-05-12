function Tail-Log
{
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $Path,
         [Parameter(Mandatory=$false, Position=1)]
         [bool] $Full
    )

    if (Get-Command "bat" -ErrorAction SilentlyContinue) { 
        if($Full){
            Get-Content $Path -Wait | ForEach-Object { if($_.Contains('ERROR:')){Write-Host $_ -ForegroundColor Red } else { $_ | bat -l log --paging=never --style=plain -f}}
        }
        else{
            Get-Content $Path -Wait -Tail 1 | ForEach-Object { if($_.Contains('ERROR:')){Write-Host $_ -ForegroundColor Red } else { $_ | bat -l log --paging=never --style=plain -f}}
        }
    }
    else {
        if($Full){
            Get-Content $Path -Wait | ForEach-Object { if($_.Contains('ERROR:')){Write-Host $_ -ForegroundColor Red } else {Write-Host $_ }}
        }
        else{
            Get-Content $Path -Wait -Tail 1 | ForEach-Object { if($_.Contains('ERROR:')){Write-Host $_ -ForegroundColor Red } else {Write-Host $_ }}
        }
    }
}
