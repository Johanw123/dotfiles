function Invoke-Starship-PreCommand {
  $host.ui.Write("`e]0; terminal `a")
}

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Remove-Alias cd
Set-Alias cd z

Import-Module PSReadLine
Import-Module -Name CompletionPredictor

# Other hosts (ISE, ConEmu) don't always work as well with PSReadLine.
# Also, if PS is run with -Command, PSRL loading is suppressed.
$psrlMod = Get-Module PSReadLine
if (($null -eq $psrlMod) -or ($host.Name -eq 'Windows PowerShell ISE Host')) {
    return
}
elseif ($psrlMod.Version.Major -lt 2) {
    throw "PSReadLine 1.x installed or not imported, import PSRL or ugprade to at least 2.x."
}

if ((Get-Module PSReadLine).Version.Major -lt 2) {
    throw "PSReadLine 1.x installed or not imported, import PSRL or ugprade to at least 2.x."
}

# Configure PSReadLine options
$darkGray = "$([char]27)[38;2;192;192;192m"
$options = @{
    Colors                        = @{ Parameter = $darkGray; Operator = $darkGray }
    ExtraPromptLineCount          = 5
    MaximumHistoryCount           = 10000
    HistorySavePath               = "$PSScriptRoot\PSReadLine_history.txt"
    HistoryNoDuplicates           = $true
    HistorySearchCursorMovesToEnd = $true
    PromptText                    = "> "
    AddToHistoryHandler           = {
        param([string]$line)
        return $line.Length -gt 3 -and $line[0] -ne ' ' -and $line[0] -ne ';'
    }
}

# Need >= 2.1
if ($psrlMod.Version.Minor -ge 1) {
    $options['PredictionSource'] = 'HistoryAndPlugin'
}

# Need >= 2.2
if ($psrlMod.Version.Minor -ge 2) {
    $options['PredictionViewStyle'] = 'ListView'
}

Set-PSReadLineOption @options

#Set-PSReadLineOption -PredictionSource HistoryAndPlugin


# VIM STUFF??
# Set-PSReadLineOption -EditMode Vi

# Set-PSReadLineKeyHandler -vimode insert -Chord "k" -ScriptBlock { mapTwoLetterNormal 'k' 'j' }
# Set-PSReadLineKeyHandler -vimode insert -Chord "j" -ScriptBlock { mapTwoLetterNormal 'j' 'k' }
# function mapTwoLetterNormal($a, $b){
#   mapTwoLetterFunc $a $b -func $function:setViCommandMode
# }
# function setViCommandMode{
#     [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
# }

# function mapTwoLetterFunc($a,$b,$func) {
#   if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()) {
#     $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
#     if ($key.Character -eq $b) {
#         &$func
#     } else {
#       [Microsoft.Powershell.PSConsoleReadLine]::Insert("$a")
#       # Representation of modifiers (like shift) when ReadKey uses IncludeKeyDown
#       if ($key.Character -eq 0x00) {
#         return
#       } else {
#         # Insert func above converts escape characters to their literals, e.g.
#         # converts return to ^M. This doesn't.
#         $wshell = New-Object -ComObject wscript.shell
#         $wshell.SendKeys("{$($key.Character)}")
#       }
#     }
#   }
# }


# Bonus example
# function replaceWithExit {
#     [Microsoft.PowerShell.PSConsoleReadLine]::BackwardKillLine()
#     [Microsoft.PowerShell.PSConsoleReadLine]::KillLine()
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('exit')
# }
# Set-PSReadLineKeyHandler -Chord ";" -ScriptBlock { mapTwoLetterFunc ';' 'q' -func $function:replaceWithExit }


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

function lse_alias_unix { eza --icons -F -H --group-directories-first --git -1 }
Set-Alias -Name lse -Value lse_alias_unix -Option AllScope

function ll_alias_unix { eza --icons -F -H --group-directories-first --git -1 -alF }
Set-Alias -Name ll -Value ll_alias_unix -Option AllScope

Set-Alias -Name ls -Value eza

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

function sudo!
{
    $commandLine = (Get-History | Select-Object -Last 1).CommandLine
    Start-Process -FilePath powershell.exe -ArgumentList $commandLine -Verb runas
}

function sudo ($scriptblock)
{
  # TODO: make -NoExit a parameter
  # TODO: just open PS (no -Command parameter) if $scriptblock -eq ''
  $sh = new-object -com 'Shell.Application'
  $sh.ShellExecute('powershell', "-NoExit -Command $scriptblock", '', 'runas')
}

#https://github.com/kelleyma49/PSFzf?tab=readme-ov-file#helper-functions
function RipGrepFunc([string] $s) {Invoke-PsFzfRipgrep $s}
Set-Alias -Name rgf -Value RipGrepFunc

Set-Alias -Name fd -Value Invoke-FuzzySetLocation
Set-Alias -Name fgs -Value Invoke-FuzzyGitStatus
Set-Alias -Name fkill -Value Invoke-FuzzyKillProcess
Set-Alias -Name fz -Value Invoke-FuzzyZoxide

Set-Alias -Name ff -Value FindFile

Set-Alias -Name lfd -Value ListFilesSortedDate

function FindFile()
{
    Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf | Invoke-Item
}

function ListFilesSortedDate()
{
    Get-ChildItem $dir -Recurse -File | Select-Object LastWriteTime, FullName | Sort-Object LastWriteTime
}

function OpenCurrentDir()
{
  Invoke-Item .
}
Set-Alias -Name e -Value OpenCurrentDir 

function FuzzyEditFunc() {
  fzf --preview='bat --color=always --theme=ansi --style=numbers {}'| % { vim $_ }
  #Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf | % { vim $_ }
}

Set-Alias -Name fe -Value FuzzyEditFunc

#function Wsl-Ollama { wsl ollama run mistral }
#Set-Alias -Name ollama -Value Wsl-Ollama 

function List-Commands {
  bat --language=help -f $home\dotfiles\Powershell\list.txt
}
Set-Alias -Name list -Value List-Commands

# From https://github.com/nickmhankins/Handle
function Test-AcceptedEula {

    # Test if the EulaAccepted property exists and create it if it does not
    if((Get-ItemProperty HKCU:\Software\Sysinternals\Handle -ErrorAction SilentlyContinue).EulaAccepted -ne '1') {
            & reg.exe ADD HKCU\Software\Sysinternals\Handle /v EulaAccepted /t REG_DWORD /d 1 /f 2>&1>$null
            Write-Host 'Eula has been auto-accepted'
        }

}

Function Test-RunAsAdmin{
    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){
        $False
    }
    else {
        $True
    }
}

Function Get-LockedFiles {

    [cmdletbinding()]

    param (
            [Parameter(Mandatory,Position=0,ValueFromPipeline)]
            [ValidateScript({Test-Path $_})]
            [string]$Path
    )
    
    Begin {
        Test-AcceptedEula
    }
    Process {
        $HandleCollection = @()

        $Output = & handle.exe $Path
        $Lines = $Output.trim() -like "*pid:*"
        if($Lines) {
            foreach($Line in $Lines){
                $Result = $Line | Select-String -Pattern '^([^ ]*)\s*pid: ([0-9]*)\s*type: ([^ ]*)\s*([^ ]*)\s*(.*?): (.*)'
                $Handle = [PSCustomObject] @{
                    ProcessName =  $Result.Matches[0].Groups[1].Value
                    ProcessId = [int]::Parse( $Result.Matches[0].Groups[2].Value)
                    Type = $Result.Matches[0].Groups[3].Value
                    User = $Result.Matches[0].Groups[4].Value
                    Path = $Result.Matches[0].Groups[6].Value
                }
                $HandleCollection += $Handle    
            }
            return $HandleCollection     
        }
        else {
            Write-Host "No locked files found or parent process already closed" -ForegroundColor Yellow
        }       
    }
}

Function Close-LockedFiles {

    [cmdletbinding()]

    param (
            [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName,ValueFromPipeline)]
            [ValidateScript({Test-Path $_})]
            [string]$Path
    )

        Begin {
            Test-AcceptedEula
        }
        Process {
        Get-LockedFiles -Path $Path | ForEach-Object {      
            & handle.exe -c $_.User -p $_.ProcessId -y 2>&1>$null
            Write-Host "Closed PID $($_.ProcessID) running in path $($_.Path)" -ForegroundColor Green     
        }  
    }        
}


# Function to get history of saved locations
function StupidHist {
 $historyLocation = $(Get-PSReadLineOption).HistorySavePath
 $all = Get-Content $historyLocation | select-string -Pattern "^cd .:" | %{ echo ($_ -replace "^cd (.*)","`$1") } | Sort-Object -Unique 
 return $all | Where-Object { Test-Path $($_) }
}
# Function to change to the last visited location
function CdLast {
    $location = StupidHist | FZF
    if ($location) {
        Set-Location $location
    }
}
# Create an alias for CdLast
Set-Alias q CdLast

function Invoke-FuzzyZoxide() {
    $result = $null
    try {
        (zoxide query --list) | Invoke-Fzf -NoSort | ForEach-Object { $result = $_ }
    }
    catch {

    }
    if ($null -ne $result) {
        # use cd in case it's aliased to something else:
        cd $result
    }
}


function WingetInstallPackage()
{
    $package_id = winget search --query "" | Invoke-Fzf -Height 100% | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() }
    winget install -e --id $package_id
}

Set-Alias -Name wip -Value WingetInstallPackage

# Plastic stuff
function FuzzySwitchBranch(){
    $branch = cm find branches --format="{name}" --nototal | fzf
    cm switch $branch
}

Set-Alias -Name fsb -Value FuzzySwitchBranch

function FuzzyGitDiff()
{
    git diff --name-only | fzf -m --ansi --preview 'git diff --color=always {-1} | delta -s -w %FZF_PREVIEW_COLUMNS%' --preview-window='up,80%,border-bottom,+{2}+3/3,~3' | % { vim $_ }
}

Set-Alias -Name fgd -Value FuzzyGitDiff