$ENV:STARSHIP_CONFIG = "$HOME\dotfiles\Powershell\starship.toml"

function Invoke-Starship-PreCommand {
  $host.ui.Write("`e]0; terminal `a")
}

Invoke-Expression (&starship init powershell)



Set-Alias -Name np -Value C:\Windows\notepad.exe
Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim


function cd-susrepo1 { set-location "G:\dev\susrepo1" }
new-alias cd-sus gotosusrepo1
function cd-susrepo1_2 { set-location "G:\dev\susrepo1_2" }
new-alias cd-sus2 gotosusrepo1_2

function cd-appl { set-location "~\AppData\Local" }
function cd-appr { set-location "~\AppData\Roaming" }
function cd-home { set-location "~" }
function cd-nvim { set-location "~\dotfiles\.config\nvim\lua\custom" }
function cd-conan { set-location "~\.conan" }
function cd-dot { set-location "~\dotfiles" }

function cd-dsus { set-location D:\Dev\SurgicalScience }

function cd_devc { set-location C:\Dev }
function cd_devd { set-location D:\Dev }

function cd-smb { set-location C:\Dev\SquareManBoy }
function cd-dr { set-location D:\Dev\DungeonRun\DungeonRun }



function ls_alias_detailed { Get-ChildItem $args -Exclude .* }
Set-Alias -Name lsd -Value ls_alias_detailed -Option AllScope

function ls_alias_c1 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 1 -Property Name }
Set-Alias -Name ls1 -Value ls_alias_c1 -Option AllScope

function ls_alias_c2 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 2 -Property Name }
Set-Alias -Name ls2 -Value ls_alias_c2 -Option AllScope

function ls_alias_c3 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 3 -Property Name }
Set-Alias -Name ls3 -Value ls_alias_c3 -Option AllScope

function ls_alias_c4 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 4 -Property Name }
Set-Alias -Name ls4 -Value ls_alias_c4 -Option AllScope

function ls_alias_c5 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 5 -Property Name }
Set-Alias -Name ls5 -Value ls_alias_c5 -Option AllScope

function ls_alias_unix { wsl ls --color=auto -hF $args }
Set-Alias -Name lsu -Value ls_alias_unix -Option AllScope

function lse_alias_unix { wsl exa --icons -F -H --group-directories-first --git -1 }
Set-Alias -Name lse -Value lse_alias_unix -Option AllScope

function ll_alias_unix { wsl exa --icons -F -H --group-directories-first --git -1 -alF }
Set-Alias -Name ll -Value ll_alias_unix -Option AllScope

function ls_alias { lse }
Set-Alias -Name ls -Value ls_alias_detailed -Option AllScope


function drives {Get-PsDrive -PSProvider 'FileSystem'}
Set-Alias ds drives

Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive

function ssh_truls { ssh johanw@172.31.232.86 }
new-alias truls ssh_truls

function ssh_linbox { ssh root@172.31.231.5 }
new-alias linbox ssh_linbox

function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
} 