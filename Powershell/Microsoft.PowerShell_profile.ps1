Invoke-Expression (&starship init powershell)

Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim

Set-Alias grep findstr
Set-Alias touch New-Item

Set-Alias ds drives

Set-Alias wget Invoke-WebRequest

Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive

Set-Alias g git

function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
} 

function drives {gdr -PSProvider 'FileSystem'}

function cd-nvim { cd C:\Users\Johan\AppData\Local\nvim }
function cd-smb { cd C:\Dev\SquareManBoy }
function cd-dr { cd D:\Dev\DungeonRun\DungeonRun }

function cd_appl { cd C:\Users\Johan\AppData\Local }
function cd_app { cd C:\Users\Johan\AppData }
function cd_appr { cd C:\Users\Johan\AppData\Roaming }

function cd_devc { cd C:\Dev }
function cd_devd { cd D:\Dev }

function cd-sus { cd D:\Dev\SurgicalScience }
function cd-susrepo { cd D:\Dev\SurgicalScience\susrepo1}