function Invoke-Starship-PreCommand {
  $host.ui.Write("`e]0; terminal `a")
}

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Import-Module PSReadLine
Import-Module -Name CompletionPredictor
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

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
    #Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    $options['PredictionSource'] = 'HistoryAndPlugin'
}

# Need >= 2.2
if ($psrlMod.Version.Minor -ge 2) {
    $options['PredictionViewStyle'] = 'ListView'
}

Set-PSReadLineOption @options

# Includes
. "$home\dotfiles\Powershell\scripts\Tail-Log.ps1"




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



# Functions
function cd-susrepo1 { set-location "G:\dev\susrepo1" }
function cd-susrepo1_2 { set-location "G:\dev\susrepo1_2" }
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
function ls_alias_c2 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 2 -Property Name }
function ls_alias_c3 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 3 -Property Name }
function ls_alias_c4 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 4 -Property Name }
function ls_alias_c5 { Get-ChildItem $args -Exclude .*  | Format-Wide -Column 5 -Property Name }
function ls_alias_unix { wsl ls --color=auto -hF $args }
function lse_alias_unix { eza --icons -F -H --group-directories-first --git -1 }
function ll_alias_unix { eza --icons -F -H --group-directories-first --git -1 -alF }

function drives {Get-PsDrive -PSProvider 'FileSystem'}
function ssh_truls { ssh johanw@172.31.232.86 }
function ssh_linbox { ssh root@172.31.231.5 }

function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
} 

function sudo! {
    $commandLine = (Get-History | Select-Object -Last 1).CommandLine
    Start-Process -FilePath powershell.exe -ArgumentList $commandLine -Verb runas
}

function sudo ($scriptblock) {
  # TODO: make -NoExit a parameter
  # TODO: just open PS (no -Command parameter) if $scriptblock -eq ''
  $sh = new-object -com 'Shell.Application'
  $sh.ShellExecute('powershell', "-NoExit -Command $scriptblock", '', 'runas')
}

function su () {    
    Start-Process pwsh -Verb runAs
}

#https://github.com/kelleyma49/PSFzf?tab=readme-ov-file#helper-functions
function RipGrepFunc([string] $s) {Invoke-PsFzfRipgrep $s}

function FuzzyFindFile() {
    param(
        [string]$target = '',
        [string]$filter = ''
        )

    #Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf -Height 100% | Invoke-Item
    rff $target $filter | fzf -m --ansi | Invoke-Item
}

function ListFilesSortedDate() {
    Get-ChildItem $dir -Recurse -File | Select-Object LastWriteTime, FullName | Sort-Object LastWriteTime
}

function OpenCurrentDir() {
  Invoke-Item .
}

function FuzzyEditFunc() {
  fzf --preview='bat --color=always --theme=ansi --style=numbers {}'| % { vim $_ }
}

function List-Commands {
    bat --language=help --style=plain --paging=never -f $home\dotfiles\Powershell\list.txt
}

# From https://github.com/nickmhankins/Handle
function Test-AcceptedEula {
    # Test if the EulaAccepted property exists and create it if it does not
    if((Get-ItemProperty HKCU:\Software\Sysinternals\Handle -ErrorAction SilentlyContinue).EulaAccepted -ne '1') {
            & reg.exe ADD HKCU\Software\Sysinternals\Handle /v EulaAccepted /t REG_DWORD /d 1 /f 2>&1>$null
            Write-Host 'Eula has been auto-accepted'
        }
}

Function Test-RunAsAdmin {
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

function StupidHist {
    $historyLocation = $(Get-PSReadLineOption).HistorySavePath
    $all = Get-Content $historyLocation | select-string -Pattern "^cd .:" | %{ echo ($_ -replace "^cd (.*)","`$1") } | Sort-Object -Unique 
    return $all | Where-Object { Test-Path $($_) }
}

function CdLast {
    $location = StupidHist | FZF
    if ($location) {
        Set-Location $location
    }
}

function Invoke-FuzzyZoxide() {
    $result = $null
    try {
        (zoxide query --list) | Invoke-Fzf -NoSort -Height 80% | ForEach-Object { $result = $_ }
    }
    catch {

    }
    if ($null -ne $result) {
        cd $result
    }
}

function WingetInstallPackage() {
    $package_id = winget search --query "" | Invoke-Fzf -Height 100% | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() }
    winget install -e --id $package_id
}

function FuzzySwitchBranch() {
    $is_git = git rev-parse --is-inside-work-tree
    if($is_git -eq $true ) {
        $branch = cm find branches --format="{name}" --nototal | fzf
        cm switch $branch
    }
    else {
        Write-Output "Fail!"
    }
}

function FuzzyGitBranch() {
    $is_git = git rev-parse --is-inside-work-tree
    if($is_git -eq $true ) {
        $cur_branch= git symbolic-ref HEAD
        $cur_branch = $cur_branch.split('/')[-1]
        $default_branch = git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
        $branch = & {git branch --sort=-committerdate; git branch --sort=-committerdate --remote} | rg -v HEAD |  sed 's/^[ \*]*//' | fzf -m --ansi --preview="git diff --stat=80,50 --merge-base ${default_branch} --color=always {}" --preview="git log {} -1 && echo: && echo: && git diff --stat=80,50 --color=always {} --merge-base ${cur_branch}" 
        if ($branch) { 
            $branch = $branch.Replace("origin/", "")
            git switch $branch
        }
    }
    else {
        Write-Output "Fail!"
    }
}

function FuzzyGitDiff() {
    $is_git = git rev-parse --is-inside-work-tree
    if($is_git -eq $true ){
        $root=git rev-parse --show-toplevel
        Push-Location $root
        git diff --name-only | fzf -m --ansi --preview 'git diff --color=always {-1} | delta -s -w %FZF_PREVIEW_COLUMNS%' --preview-window='up,80%,border-bottom,+{2}+3/3,~3' | % { vim $_ }
        Pop-Location
    }
    else {
        Write-Output "Fail!"
    }
}

function GitFuzzy()
{
    wsl git fuzzy
}

function RipgrepFindString() {
    # this function is adapted from https://github.com/junegunn/fzf/blob/master/ADVANCED.md#switching-between-ripgrep-mode-and-fzf-mode
    param([Parameter(Mandatory)]$SearchString, [string]$filter)

    $RG_PREFIX = "rg --column --line-number --no-heading --color=always --smart-case" 
    $INITIAL_QUERY = $SearchString

    try {
            $sleepCmd = ''
            $trueCmd = 'cd .'
            $rgfilter = ''
            $promt = "🔎 ripgrep> "

            if (-not [string]::IsNullOrEmpty($filter)) {
                $rgfilter = " -g $filter"
                $promt = "🔎 ripgrep (filter: $filter)> "
            }

        # Perhaps parse from search string a -f "*.cpp" etc to have it in the initial query?
        $env:FZF_DEFAULT_COMMAND = "$RG_PREFIX ""$INITIAL_QUERY""$rgfilter || $trueCmd"

        fzf --ansi --color "hl:-1:underline,hl+:-1:underline:reverse" --disabled --query "$INITIAL_QUERY" --bind "change:reload:$sleepCmd $RG_PREFIX {q}$rgfilter || $trueCmd" --prompt $promt --delimiter : --preview 'bat --color=always {1} --highlight-line {2} --theme=TwoDark' --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' | ForEach-Object { $results += $_ }

        if (-not [string]::IsNullOrEmpty($results)) {
            $split = $results.Split(':')
            $fileList = $split[0]
            $lineNum = $split[1]
         
            $cmd = '';
            $editorOptions = ''
            $editor = 'nvim'

            if ($fileList -is [array] -and $fileList.length -gt 1) {
                for ($i = 0; $i -lt $fileList.Count; $i++) {
                    $fileList[$i] = '"{0}"' -f $(Resolve-Path $fileList[$i].Trim('"'))
                }
                $cmd = "$editor$editorOptions {0}" -f ($fileList -join ' ')
            }
            else {
                $cmd = "$editor$editorOptions ""{0}"" +{1}" -f $(Resolve-Path $fileList.Trim('"')), $LineNum
            }

            Write-Host "Executing '$cmd'..."
            Invoke-Expression -Command $cmd
        }
    }
    catch {
        Write-Error "Error occurred: $_"
    }
    finally {
    }
}

function Get-InstalledApps {
    param (
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$ComputerName = $env:COMPUTERNAME,
        [string]$NameRegex = ''
    )
    
    foreach ($comp in $ComputerName) {
        $keys = '','\Wow6432Node'
        foreach ($key in $keys) {
            try {
                $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $comp)
                $apps = $reg.OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall").GetSubKeyNames()
            } catch {
                continue
            }

            foreach ($app in $apps) {
                $program = $reg.OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall\$app")
                $name = $program.GetValue('DisplayName')
                if ($name -and $name -match $NameRegex) {
                    [pscustomobject]@{
                        ComputerName = $comp
                        DisplayName = $name
                        DisplayVersion = $program.GetValue('DisplayVersion')
                        Publisher = $program.GetValue('Publisher')
                        InstallDate = $program.GetValue('InstallDate')
                        UninstallString = $program.GetValue('UninstallString')
                        Bits = $(if ($key -eq '\Wow6432Node') {'64'} else {'32'})
                        Path = $program.name
                    }
                }
            }
        }
    }
}

#((Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }}).VersionInfo.ProductName

function LaunchProgram() {
    #--no-sort
    #(Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | select fullname,lastaccesstime | sort -Property lastaccesstime -Descending |  Select-Object -ExpandProperty FullName | fzf | Invoke-Item
    (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | Select-Object -ExpandProperty VersionInfo | select ProductName,FileName | Format-Table -HideTableHeaders | fzf | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() } | Invoke-Item}

function LaunchApp() {
    #--no-sort
    Get-StartApps | Where-Object { $_.AppID -like "*.exe" } | Format-Table -HideTableHeaders | fzf --ansi -m | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() } | Invoke-Item

   # (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | Select-Object -ExpandProperty VersionInfo | select FileName, ProductName
}

function LaunchBoth() {
    #--no-sort
    $apps = Get-StartApps | Where-Object { $_.AppID -like "*.exe" } | Select-Object @{Name="Name";Expression={$_.Name}},@{Name="Path";Expression={$_.AppID}}
    $programs = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | Select-Object -ExpandProperty VersionInfo | select ProductName,FileName | Select-Object @{Name="Name";Expression={$_.ProductName}},@{Name="Path";Expression={$_.FileName}}
    $all = @($apps) + $programs
    $all | Format-Table -HideTableHeaders | fzf --ansi -m | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() } | Invoke-Item
   # (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | Select-Object -ExpandProperty VersionInfo | select FileName, ProductName
}

function LaunchRecent(){
    (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | select fullname,lastaccesstime | sort -Property lastaccesstime -Descending |  Select-Object -ExpandProperty FullName | fzf | Invoke-Item
}

function MentorLearnLog {
    #winget install sharkdp.bat
    #Get-Content $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -Wait -Tail 1 | ForEach-Object { bat $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -l log --paging=never --style=plain -f -r $_.Length}

    # Get-Content $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -Wait -Tail 1 | ForEach-Object { if($_ -like ""){Write-Output $_ -ForegroundColor Red } else {bat $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -l log --paging=never --style=plain -f -r $_.Length}}

    # #Get-Content $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -Wait -Tail 1 | bat -l log --paging=never --style=plain -f
    # Get-Content $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -Wait | bat -l log --paging=never --style=plain -f

    Tail-Log $env:LOCALAPPDATA\Temp\EnvelopeLog.txt
}

function RipgrepFindFile {
    param(
        [string]$target,
        [string]$filter = ''
        )

    rg --files -g $filter | rg $target --color=always --smart-case
}

function NvimKickstart {
    #alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    $env:NVIM_APPNAME = 'nvim-kickstart'
    nvim
}


#git 
function GitStatus {
    git status
}

function GitDiff {
    git difftool --dir-diff
}

#| Format-Table -HideTableHeaders

# Aliases   
Remove-Alias cd
Set-Alias cd z

Set-Alias -Name np -Value C:\Windows\notepad.exe
Set-Alias -Name vi -Value nvim-kickstart
Set-Alias -Name vim -Value nvim-kickstart
Set-Alias -Name nvim -Value nvim-kickstart

Set-Alias -Name rgf -Value RipGrepFunc
Set-Alias -Name fd -Value Invoke-FuzzySetLocation

Set-Alias -Name fkill -Value Invoke-FuzzyKillProcess
Set-Alias -Name fz -Value Invoke-FuzzyZoxide
Set-Alias -Name fff -Value FuzzyFindFile

Set-Alias -Name lfd -Value ListFilesSortedDate

Set-Alias -Name fgs -Value Invoke-FuzzyGitStatus
Set-Alias -Name fgd -Value FuzzyGitDiff
Set-Alias -Name fgb -Value FuzzyGitBranch

Set-Alias -Name rff -Value RipgrepFindFile
Set-Alias -Name rfs -Value RipgrepFindString

Set-Alias q CdLast
Set-Alias -Name wip -Value WingetInstallPackage
Set-Alias -Name fsb -Value FuzzySwitchBranch

Set-Alias -Name e -Value OpenCurrentDir 
Set-Alias -Name fe -Value FuzzyEditFunc
Set-Alias -Name list -Value List-Commands

Set-Alias -Name gs -Value GitStatus
Set-Alias -Name gd -Value GitDiff

Set-Alias ds drives

Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive

Set-Alias -Name ll -Value ll_alias_unix -Option AllScope

Set-Alias -Name ls -Value eza

Set-Alias -Name ls1 -Value ls_alias_c1 -Option AllScope
Set-Alias -Name ls2 -Value ls_alias_c2 -Option AllScope
Set-Alias -Name ls3 -Value ls_alias_c3 -Option AllScope
Set-Alias -Name ls4 -Value ls_alias_c4 -Option AllScope
Set-Alias -Name ls5 -Value ls_alias_c5 -Option AllScope
Set-Alias -Name lsu -Value ls_alias_unix -Option AllScope
Set-Alias -Name lse -Value lse_alias_unix -Option AllScope

new-alias linbox ssh_linbox
new-alias truls ssh_truls

new-alias cd-sus2 gotosusrepo1_2
new-alias cd-sus gotosusrepo1

Set-Alias -Name lp -Value LaunchProgram
Set-Alias -Name la -Value LaunchApp
Set-Alias -Name lb -Value LaunchBoth
Set-Alias -Name lr -Value LaunchRecent

Set-Alias -Name mll -Value MentorLearnLog
Set-Alias -Name tl -Value Tail-Log


#https://keyneston.com/posts/fgit/
Set-Alias -Name gf -Value GitFuzzy

Set-Alias -Name nvim-kickstart -Value NvimKickstart