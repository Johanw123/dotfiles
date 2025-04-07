function Invoke-Starship-PreCommand
{
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
if (($null -eq $psrlMod) -or ($host.Name -eq 'Windows PowerShell ISE Host'))
{
    return
} elseif ($psrlMod.Version.Major -lt 2)
{
    throw "PSReadLine 1.x installed or not imported, import PSRL or ugprade to at least 2.x."
}

if ((Get-Module PSReadLine).Version.Major -lt 2)
{
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
if ($psrlMod.Version.Minor -ge 1)
{
    #Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    $options['PredictionSource'] = 'HistoryAndPlugin'
}

# Need >= 2.2
if ($psrlMod.Version.Minor -ge 2)
{
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
function cd-susrepo1
{ set-location "G:\dev\susrepo1" 
}
function cd-susrepo1_2
{ set-location "G:\dev\susrepo1_2" 
}
function cd-appl
{ set-location "~\AppData\Local" 
}
function cd-appr
{ set-location "~\AppData\Roaming" 
}
function cd-home
{ set-location "~" 
}
function cd-nvim
{ set-location "~\dotfiles\.config\nvim\lua\custom" 
}
function cd-conan
{ set-location "~\.conan" 
}
function cd-dot
{ set-location "~\dotfiles" 
}
function cd-dsus
{ set-location D:\Dev\SurgicalScience 
}
function cd_devc
{ set-location C:\Dev 
}
function cd_devd
{ set-location D:\Dev 
}
function cd-smb
{ set-location C:\Dev\SquareManBoy 
}
function cd-dr
{ set-location D:\Dev\DungeonRun\DungeonRun 
}

function ls_alias_c1
{ Get-ChildItem $args -Exclude .*  | Format-Wide -Column 1 -Property Name 
}
function ls_alias_c2
{ Get-ChildItem $args -Exclude .*  | Format-Wide -Column 2 -Property Name 
}
function ls_alias_c3
{ Get-ChildItem $args -Exclude .*  | Format-Wide -Column 3 -Property Name 
}
function ls_alias_c4
{ Get-ChildItem $args -Exclude .*  | Format-Wide -Column 4 -Property Name 
}
function ls_alias_c5
{ Get-ChildItem $args -Exclude .*  | Format-Wide -Column 5 -Property Name 
}
function ls_alias_unix
{ wsl ls --color=auto -hF $args 
}
function lse_alias_unix
{ eza --icons -F -H --group-directories-first --git -1 
}
function ll_alias_unix
{ eza --icons -F -H --group-directories-first --git -1 -alF 
}

function drives
{ Get-PsDrive -PSProvider 'FileSystem' 
}
function ssh_truls
{ ssh johanw@172.31.232.86 
}
function ssh_linbox
{ ssh root@172.31.231.5 
}

function Open-GitHub
{
    $is_git = git rev-parse --is-inside-work-tree
    if ($is_git -eq $true )
    {
        $fetch_url = (git config --get remote.origin.url)
        $github_url = ""
        
        if ($fetch_url -like "*https*")
        {
            $github_url = $fetch_url
        } else
        {
            $url_split = $fetch_url.Split(":")
            if ($url_split.Count -gt 1)
            {
                $url_portion = $url_split[1]
                $github_url = "https://github.com/" + $url_portion
            } else
            {
                Write-Host "Could not parse Github Path"
            }
        }

        if ($github_url)
        {
            firefox $github_url
        } else
        {
            Write-Host "Not a valid Url!" -ForegroundColor red
        }
    } else
    {
        Write-Host "Not in a git repo!" -ForegroundColor red
    }
}

function which ($command)
{
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

function su ()
{    
    Start-Process pwsh -Verb runAs
}

#https://github.com/kelleyma49/PSFzf?tab=readme-ov-file#helper-functions
function RipGrepFunc([string] $s)
{ Invoke-PsFzfRipgrep $s 
}

function FuzzyFindFile()
{
    param(
        [string]$target = '',
        [string]$filter = ''
    )

    #Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf -Height 100% | Invoke-Item
    rff $target $filter | fzf -m --ansi | Invoke-Item
}

function ListFilesSortedDate()
{
    Get-ChildItem $dir -Recurse -File | Select-Object LastWriteTime, FullName | Sort-Object LastWriteTime
}

function OpenCurrentDir()
{
    Invoke-Item .
}

function FuzzyEditFunc()
{
    fzf --preview='bat --color=always --theme=ansi --style=numbers {}' | % { vim $_ }
}

function List-Commands
{
    bat --language=help --style=plain --paging=never -f $home\dotfiles\Powershell\list.txt
}

# From https://github.com/nickmhankins/Handle
function Test-AcceptedEula
{
    # Test if the EulaAccepted property exists and create it if it does not
    if ((Get-ItemProperty HKCU:\Software\Sysinternals\Handle -ErrorAction SilentlyContinue).EulaAccepted -ne '1')
    {
        & reg.exe ADD HKCU\Software\Sysinternals\Handle /v EulaAccepted /t REG_DWORD /d 1 /f 2>&1>$null
        Write-Host 'Eula has been auto-accepted'
    }
}

Function Test-RunAsAdmin
{
    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        $False
    } else
    {
        $True
    }
}

Function Get-LockedFiles
{

    [cmdletbinding()]

    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [ValidateScript({ Test-Path $_ })]
        [string]$Path
    )
    
    Begin
    {
        Test-AcceptedEula
    }
    Process
    {
        $HandleCollection = @()

        $Output = & handle.exe $Path
        $Lines = $Output.trim() -like "*pid:*"
        if ($Lines)
        {
            foreach ($Line in $Lines)
            {
                $Result = $Line | Select-String -Pattern '^([^ ]*)\s*pid: ([0-9]*)\s*type: ([^ ]*)\s*([^ ]*)\s*(.*?): (.*)'
                $Handle = [PSCustomObject] @{
                    ProcessName = $Result.Matches[0].Groups[1].Value
                    ProcessId   = [int]::Parse( $Result.Matches[0].Groups[2].Value)
                    Type        = $Result.Matches[0].Groups[3].Value
                    User        = $Result.Matches[0].Groups[4].Value
                    Path        = $Result.Matches[0].Groups[6].Value
                }
                $HandleCollection += $Handle    
            }
            return $HandleCollection     
        } else
        {
            Write-Host "No locked files found or parent process already closed" -ForegroundColor Yellow
        }       
    }
}

Function Close-LockedFiles
{

    [cmdletbinding()]

    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateScript({ Test-Path $_ })]
        [string]$Path
    )

    Begin
    {
        Test-AcceptedEula
    }
    Process
    {
        Get-LockedFiles -Path $Path | ForEach-Object {      
            & handle.exe -c $_.User -p $_.ProcessId -y 2>&1>$null
            Write-Host "Closed PID $($_.ProcessID) running in path $($_.Path)" -ForegroundColor Green     
        }  
    }        
}

function StupidHist
{
    $historyLocation = $(Get-PSReadLineOption).HistorySavePath
    $all = Get-Content $historyLocation | select-string -Pattern "^cd .:" | % { echo ($_ -replace "^cd (.*)", "`$1") } | Sort-Object -Unique 
    return $all | Where-Object { Test-Path $($_) }
}

function CdLast
{
    $location = StupidHist | FZF
    if ($location)
    {
        Set-Location $location
    }
}

function Invoke-FuzzyZoxide()
{
    $result = $null
    try
    {
        (zoxide query --list) | Invoke-Fzf -NoSort -Height 80% | ForEach-Object { $result = $_ }
    } catch
    {

    }
    if ($null -ne $result)
    {
        cd $result
    }
}

function WingetInstallPackage()
{
    $package_id = winget search --query "" | Invoke-Fzf -Height 100% | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() }
    winget install -e --id $package_id
}

function FuzzySwitchBranch()
{
    $is_git = git rev-parse --is-inside-work-tree
    if ($is_git -eq $true )
    {
        $branch = cm find branches --format="{name}" --nototal | fzf
        cm switch $branch
    } else
    {
        Write-Output "Fail!"
    }
}

function FuzzyGitBranch()
{
    $is_git = git rev-parse --is-inside-work-tree
    if ($is_git -eq $true )
    {
        $cur_branch = git symbolic-ref HEAD
        $cur_branch = $cur_branch.split('/')[-1]
        #$default_branch = git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
        $branch = & { git branch --sort=-committerdate; git branch --sort=-committerdate --remote } | rg -v HEAD |  sed 's/^[ \*]*//' | fzf -m --ansi --preview="git log {} -3 && echo: && echo: && git diff --stat=80,50 --color=always {} --merge-base ${cur_branch}" 
        if ($branch)
        { 
            $branch = $branch.Replace("origin/", "")

            & .\_scripts\remove_all_symlinks.bat
            git switch $branch            
        }
    } else
    {
        Write-Output "Fail!"
    }
}

function FuzzyGitDiff()
{
    $is_git = git rev-parse --is-inside-work-tree
    if ($is_git -eq $true )
    {
        $root = git rev-parse --show-toplevel
        Push-Location $root
        git diff --name-only | fzf -m --ansi --preview 'git diff --color=always {-1} | delta  -s -w %FZF_PREVIEW_COLUMNS%' --preview-window='up,80%,border-bottom,+{2}+3/3,~3' | % { nvim $_ }
        Pop-Location
    } else
    {
        Write-Output "Fail!"
    }
}

function GitFuzzy()
{
    wsl git fuzzy
}

function RipgrepFindString()
{
    # this function is adapted from https://github.com/junegunn/fzf/blob/master/ADVANCED.md#switching-between-ripgrep-mode-and-fzf-mode
    param([Parameter(Mandatory)]$SearchString, [string]$filter)

    $RG_PREFIX = "rg --column --line-number --no-heading --color=always --smart-case" 
    $INITIAL_QUERY = $SearchString

    try
    {
        $sleepCmd = ''
        $trueCmd = 'cd .'
        $rgfilter = ''
        $promt = "🔎 ripgrep> "

        if (-not [string]::IsNullOrEmpty($filter))
        {
            $rgfilter = " -g $filter"
            $promt = "🔎 ripgrep (filter: $filter)> "
        }

        # Perhaps parse from search string a -f "*.cpp" etc to have it in the initial query?
        $env:FZF_DEFAULT_COMMAND = "$RG_PREFIX ""$INITIAL_QUERY""$rgfilter || $trueCmd"

        fzf --ansi --color "hl:-1:underline,hl+:-1:underline:reverse" --disabled --query "$INITIAL_QUERY" --bind "change:reload:$sleepCmd $RG_PREFIX {q}$rgfilter || $trueCmd" --prompt $promt --delimiter : --preview 'bat --color=always {1} --highlight-line {2} --theme=TwoDark' --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' | ForEach-Object { $results += $_ }

        if (-not [string]::IsNullOrEmpty($results))
        {
            $split = $results.Split(':')
            $fileList = $split[0]
            $lineNum = $split[1]
         
            $cmd = '';
            $editorOptions = ''
            $editor = 'nvim'

            if ($fileList -is [array] -and $fileList.length -gt 1)
            {
                for ($i = 0; $i -lt $fileList.Count; $i++)
                {
                    $fileList[$i] = '"{0}"' -f $(Resolve-Path $fileList[$i].Trim('"'))
                }
                $cmd = "$editor$editorOptions {0}" -f ($fileList -join ' ')
            } else
            {
                $cmd = "$editor$editorOptions ""{0}"" +{1}" -f $(Resolve-Path $fileList.Trim('"')), $LineNum
            }

            Write-Host "Executing '$cmd'..."
            Invoke-Expression -Command $cmd
        }
    } catch
    {
        Write-Error "Error occurred: $_"
    } finally
    {
    }
}

function Get-InstalledApps
{
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$ComputerName = $env:COMPUTERNAME,
        [string]$NameRegex = ''
    )
    
    foreach ($comp in $ComputerName)
    {
        $keys = '', '\Wow6432Node'
        foreach ($key in $keys)
        {
            try
            {
                $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $comp)
                $apps = $reg.OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall").GetSubKeyNames()
            } catch
            {
                continue
            }

            foreach ($app in $apps)
            {
                $program = $reg.OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall\$app")
                $name = $program.GetValue('DisplayName')
                if ($name -and $name -match $NameRegex)
                {
                    [pscustomobject]@{
                        ComputerName    = $comp
                        DisplayName     = $name
                        DisplayVersion  = $program.GetValue('DisplayVersion')
                        Publisher       = $program.GetValue('Publisher')
                        InstallDate     = $program.GetValue('InstallDate')
                        UninstallString = $program.GetValue('UninstallString')
                        Bits            = $(if ($key -eq '\Wow6432Node')
                            { '64' 
                            } else
                            { '32' 
                            })
                        Path            = $program.name
                    }
                }
            }
        }
    }
}

#((Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }}).VersionInfo.ProductName

function LaunchProgram()
{
    #--no-sort
    #(Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | select fullname,lastaccesstime | sort -Property lastaccesstime -Descending |  Select-Object -ExpandProperty FullName | fzf | Invoke-Item
    (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if (Test-Path $_.Name)
        { Get-ItemProperty $_.Name 
        } } | Select-Object -ExpandProperty VersionInfo | select ProductName, FileName | Format-Table -HideTableHeaders | fzf | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() } | Invoke-Item
}

function LaunchApp()
{
    #--no-sort
    Get-StartApps | Where-Object { $_.AppID -like "*.exe" } | Format-Table -HideTableHeaders | fzf --ansi -m | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() } | Invoke-Item

    # (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | Select-Object -ExpandProperty VersionInfo | select FileName, ProductName
}

function LaunchBoth()
{
    #--no-sort
    $apps = Get-StartApps | Where-Object { $_.AppID -like "*.exe" } | Select-Object @{Name = "Name"; Expression = { $_.Name } }, @{Name = "Path"; Expression = { $_.AppID } }
    $programs = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if (Test-Path $_.Name)
        { Get-ItemProperty $_.Name 
        } } | Select-Object -ExpandProperty VersionInfo | select ProductName, FileName | Select-Object @{Name = "Name"; Expression = { $_.ProductName } }, @{Name = "Path"; Expression = { $_.FileName } }
    $all = @($apps) + $programs
    $all | Format-Table -HideTableHeaders | fzf --ansi -m | ForEach-Object { $_.split("  ", [StringSplitOptions]::RemoveEmptyEntries)[1].Trim() } | Invoke-Item
    # (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if(Test-Path $_.Name) {Get-ItemProperty $_.Name }} | Select-Object -ExpandProperty VersionInfo | select FileName, ProductName
}

function LaunchRecent()
{
    (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store').PSObject.Properties | Where-Object { $_.Name -like "*.exe" } | ForEach-Object { if (Test-Path $_.Name)
        { Get-ItemProperty $_.Name 
        } } | select fullname, lastaccesstime | sort -Property lastaccesstime -Descending |  Select-Object -ExpandProperty FullName | fzf | Invoke-Item
}

function MentorLearnLog
{
    #winget install sharkdp.bat
    #Get-Content $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -Wait -Tail 1 | ForEach-Object { bat $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -l log --paging=never --style=plain -f -r $_.Length}

    # Get-Content $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -Wait -Tail 1 | ForEach-Object { if($_ -like ""){Write-Output $_ -ForegroundColor Red } else {bat $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -l log --paging=never --style=plain -f -r $_.Length}}

    # #Get-Content $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -Wait -Tail 1 | bat -l log --paging=never --style=plain -f
    # Get-Content $env:LOCALAPPDATA\Temp\EnvelopeLog.txt -Wait | bat -l log --paging=never --style=plain -f

    Tail-Log $env:LOCALAPPDATA\Temp\EnvelopeLog.txt
}

function RipgrepFindFile
{
    param(
        [string]$target,
        [string]$filter = ''
    )

    rg --files -g $filter | rg $target --color=always --smart-case
}

function NvimKickstart
{
    #alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    $env:NVIM_APPNAME = 'nvim-kickstart'
    nvim
}


#git 
function GitStatus
{
    git status
}

function GitDiff
{
    git difftool --dir-diff
}

#| Format-Table -HideTableHeaders

# Aliases   
Remove-Alias cd
Set-Alias cd z

Set-Alias -Name np -Value C:\Windows\notepad.exe
Set-Alias -Name vi -Value nvim-kickstart
Set-Alias -Name vim -Value nvim-kickstart
#Set-Alias -Name nvim -Value nvim-kickstart

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

Set-Alias -Name gho -Value Open-GitHub


# Work Stuff

function ghcs
{
    # Debug support provided by common PowerShell function parameters, which is natively aliased as -d or -db
    # https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters?view=powershell-7.4#-debug
    param(
        [Parameter()]
        [string]$Hostname,

        [ValidateSet('gh', 'git', 'shell')]
        [Alias('t')]
        [String]$Target = 'shell',

        [Parameter(Position = 0, ValueFromRemainingArguments)]
        [string]$Prompt
    )
    begin
    {
        # Create temporary file to store potential command user wants to execute when exiting
        $executeCommandFile = New-TemporaryFile

        # Store original value of GH_* environment variable
        $envGhDebug = $Env:GH_DEBUG
        $envGhHost = $Env:GH_HOST
    }
    process
    {
        if ($PSBoundParameters['Debug'])
        {
            $Env:GH_DEBUG = 'api'
        }

        $Env:GH_HOST = $Hostname

        gh copilot suggest -t $Target -s "$executeCommandFile" $Prompt
    }
    end
    {
        # Execute command contained within temporary file if it is not empty
        if ($executeCommandFile.Length -gt 0)
        {
            # Extract command to execute from temporary file
            $executeCommand = (Get-Content -Path $executeCommandFile -Raw).Trim()

            # Insert command into PowerShell up/down arrow key history
            [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($executeCommand)

            # Insert command into PowerShell history
            $now = Get-Date
            $executeCommandHistoryItem = [PSCustomObject]@{
                CommandLine        = $executeCommand
                ExecutionStatus    = [Management.Automation.Runspaces.PipelineState]::NotStarted
                StartExecutionTime = $now
                EndExecutionTime   = $now.AddSeconds(1)
            }
            Add-History -InputObject $executeCommandHistoryItem

            # Execute command
            Write-Host "`n"
            Invoke-Expression $executeCommand
        }
    }
    clean
    {
        # Clean up temporary file used to store potential command user wants to execute when exiting
        Remove-Item -Path $executeCommandFile

        # Restore GH_* environment variables to their original value
        $Env:GH_DEBUG = $envGhDebug
    }
}

function ghce
{
    # Debug support provided by common PowerShell function parameters, which is natively aliased as -d or -db
    # https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters?view=powershell-7.4#-debug
    param(
        [Parameter()]
        [string]$Hostname,

        [Parameter(Position = 0, ValueFromRemainingArguments)]
        [string[]]$Prompt
    )
    begin
    {
        # Store original value of GH_* environment variables
        $envGhDebug = $Env:GH_DEBUG
        $envGhHost = $Env:GH_HOST
    }
    process
    {
        if ($PSBoundParameters['Debug'])
        {
            $Env:GH_DEBUG = 'api'
        }

        $Env:GH_HOST = $Hostname

        gh copilot explain $Prompt
    }
    clean
    {
        # Restore GH_* environment variables to their original value
        $Env:GH_DEBUG = $envGhDebug
        $Env:GH_HOST = $envGhHost
    }
}

function susclone
{
    # Requires GitHub CLI                                   (winget install --id GitHub.cli)
    # Requires fuzzy finder: fzf                            (winget install fzf)
    # Optional for markdown preview with colors: 'glow'     (winget install charmbracelet.glow) 

    $previewCommand = ""
    if (Get-Command "glow" -ErrorAction SilentlyContinue)
    {
        $previewCommand = "gh repo view SurgicalScience/{$_i} | glow -s dark {}" 
    } elseif (Get-Command "grip" -ErrorAction SilentlyContinue) {
        $previewCommand = "gh repo view SurgicalScience/Solidarity | grip --export -"
    } else
    {
        $previewCommand = "gh repo view SurgicalScience/{$_i}" 
    }

    gh repo list SurgicalScience -L 99999999 --json name --jq '.[].name' | fzf -m --ansi --preview $previewCommand | % { gh repo clone SurgicalScience/$_ -- --recurse-submodules} 
}


#Github
function edu_create_pr
{
    $git_branch = git rev-parse --abbrev-ref HEAD
    Write-Output "Current branch: $git_branch"

    $task = [Regex]::Match($git_branch, "EG-\d\d\d\d$").Value

    Write-Output "Parsed Ticket/Issue Id: $task"

    $summary = (jira issue view $task --raw  | jq ".fields.summary").Replace("`"","")
    $summary += " - (https://surgscience.atlassian.net/browse/$task)"
    
    Write-Output "Summary: $summary"
    
    $git_log = git log edu_develop..$git_branch --reverse --pretty=tformat:"   ~ %s<br>"
    $summary += "`n`nCommits: `n$git_log"

    Write-Output "Git Log: $git_log"
    Write-Output "Creating PR..."
    
    gh pr create --title "$task" --body "$summary" --base "edu_develop"
    
    #gh pr create --title "$task" --body "$summary" --dry-run --base "edu_develop"
    #gh pr edit 17 --title "$task" --body "$summary"
    #gh pr create --fill-verbose --dry-run --base "edu_develop"
}

function edu_create_pr_ai
{
    $git_branch = git rev-parse --abbrev-ref HEAD
    Write-Output "Current branch: $git_branch"

    $task = [Regex]::Match($git_branch, "EG-\d\d\d\d$").Value

    Write-Output "Parsed Ticket/Issue Id: $task"

    $summary = (jira issue view $task --raw  | jq ".fields.summary").Replace("`"","")
    $summary += " - (https://surgscience.atlassian.net/browse/$task)"
    
    Write-Output "Summary: $summary"
    
    $git_log = git log edu_develop..$git_branch --reverse --pretty=tformat:"   ~ %s<br>"
    $summary += "`n`nCommits: `n$git_log"

    Write-Output "Git Log: $git_log"
    
    $diff = git -c pager.diff='less -R' diff $(git merge-base edu_develop HEAD) -z
    $Promt = "You are an expert developer, so you know how to read all kinds of code syntax. Read the git patch diff calmly from top to bottom, paying attention to each addition, deletion, and unchanged line carefully. Focus on changes, not only the last or first lines, and figure out the main idea of the input. If complex, break it down into smaller parts to organize your thoughts. If JSON or declaration structures are present, pay attention to the special case mentioned above to avoid misinterpretation, but if it's a regular code, focus on the context and the changes made. Write a commit message based on the git diff provided. Read the diff below and write a commit message that accurately describes the changes made."

    Write-Output "Generating AI Summary..."

    $AiText = ollama run qwen2.5-coder:14b "$Promt $diff"
    $AiText = [string]::join("`n",($AiText.Split("`n")))

    Write-Output $AiText
    $AiText | Out-File E:\Dev\asd.txt

    Write-Output "Creating PR..."
    gh pr create --title "$task" --body "$summary `n`n`n <details><summary>AI Summary</summary>`n`n$AiText</details>"

    #gh pr create --title "$task" --body "$summary" --dry-run --base "edu_develop"
    #gh pr edit 17 --title "$task" --body "$summary `n`n`n <details><summary>AI Summary</summary>`n`n$AiText</details>"
    #gh pr create --fill-verbose --dry-run --base "edu_develop"
}

# Jira
function jira_open
{
    jira sprint list --show-all-issues --current -sopen
}

function jira_progress
{
    jira sprint list --show-all-issues --current -s "In Progress" -a "Johan Wångsell" 
}

function jira_backlog
{

}

function ask
{
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$Prompt
    )

    if ($null -eq $Prompt -or $Prompt.Length -eq 0)
    {
        throw "Prompt cannot be null or empty."
    }

    ollama run deepseek-r1:14b $Prompt
}

function TailFileBeforeEnd
{
    [System.Text.Encoding]$enc = [System.Text.Encoding]::GetEncoding(65001)
    $filename = "$env:TEMP/console_output.txt"
    $fs=New-Object System.IO.FileStream ($filename,"OpenOrCreate", "Read", "ReadWrite",8,"None") 
    $sr=New-Object System.IO.StreamReader($fs, $enc)
    $lastPosition=$sr.BaseStream.Length
    #try to find $n lines before eof
    $buffer=10240
    $ptr=$lastPosition #start at the end of the file  
    $found=0
    $n=100
    $output=@()
    $cur = ""
    $count = 0
    $blankCount = 0
    $test = 0

    if($buffer -ge $sr.BaseStream.Length)
    {
        $buffer= $sr.BaseStream.Length - 1
    }
    
    $ptr -= $buffer
    $sr.BaseStream.Seek($ptr,"Begin")|out-null #step backward
    $line = $sr.ReadLine()

    if($ptr -gt 0)
    {
        while ($line -ne $null)
        { 
            $found++
            $line=$sr.ReadLine() 
            if($line -eq $null)
            {
                continue
            }
            if($line.StartsWith("_ ➜"))
            {
                $split = $cur.Split("`n", [System.StringSplitOptions]::RemoveEmptyEntries)
                $output += $split[0 .. ($split.Length - 2)] -join "`n"
                $cur = ""
            } else
            {
                $cur += $line + "`n"
            }
        }
    }

    
    $output

    # while($ptr -gt 0 -and $found -lt $n)
    # {
    #     $ptr-=$buffer 
    #     if ($ptr -le 0)
    #     {$ptr=0
    #     }
    #     $sr.BaseStream.Seek($ptr,"Begin")|out-null #step backward
    #     $line = $sr.ReadLine()
    #     $found=0
    #     $output=@()
    #
    #     while ( $line -ne $null)
    #     { #read to the end
    #
    #         $output+=$line
    #         $found++
    #         $line=$sr.ReadLine() 
    #         if($line -contains "_ ➜")
    #         {
    #             $test += 1
    #             break
    #         }
    #     }
    #
    #     if($test -eq 1)
    #     {
    #         $sr.ReadLine()
    #         $output = ""
    #     }
    #
    #     if($test -eq 2)
    #     {
    #         break
    #     }
    #     
    #     # if($found -ge $n)
    #     # { #found enough lines
    #     #     write-verbose "ok found $found / $n"
    #     #     foreach($i in ($output.length - $n)..($output.length))
    #     #     { #take only lines needed
    #     #         $render+=$output[$i]
    #     #     }
    #     #     continue
    #     #
    #     # } else
    #     # { #move backward and retry to find lines
    #     #     write-verbose "not enough line ($found displayed)"
    #     #     $ptr-=$buffer
    #     #     if ($ptr -le 0)
    #     #     { #eof without finding suffisant lines
    #     #         $ptr=0
    #     #         write-host "not enough line ($found displayed)"
    #     #         $render=$output
    #     #
    #     #     }
    #     # }
    # }
    # $output
    # " -- - -- - - - - -"
    # $output.split("_ ➜",[System.StringSplitOptions]::RemoveEmptyEntries)[-3]
}


function explain_error
{

    [System.Text.Encoding]$enc = [System.Text.Encoding]::GetEncoding(65001)
    $BasePromt = "Hello, could you please explain this error? "
    Remove-Item $env:TEMP/console_output.txt
    #sleep 0.2
    
    sleep 1.0
    [System.IO.File]::WriteAllLines("$env:TEMP/console_output.txt", "", $enc)
    wezterm cli get-text > "$env:TEMP/console_output.txt" --start-line -1000
    sleep 1.0
    $Promt = TailFileBeforeEnd | Select-Object -Last 1
    # $result = wezterm cli get-text #--start-line -1000
    # $result = Get-Content "$env:TEMP/console_output.txt" -Raw
    # $cur = ""
    # $output = ""
    # ForEach ($line in $($result -split "`r`n"))
    # {
    #     if($line -contains "_ ➜")
    #     {
    #         $split = $cur.Split("`n", [System.StringSplitOptions]::RemoveEmptyEntries)
    #         $output += $split[0 .. ($split.Length - 2)] -join "`n"
    #         $cur = ""
    #     } else
    #     {
    #         $cur += $line + "`n"
    #     }
    #
    # }
    

    #$Promt
    ollama run zephyr:latest "$BasePromt" + "'$Promt'"
    #$Promt = Get-Content "$env:TEMP/PowershellTranscript.txt" -Raw | Split-String "_ ➜"  | Where-Object {$_} | Where-Object {$_.Trim()} | Select-Object -Last 2 | Select-Object -Index 0 
    # $Promt = Get-Content "$env:TEMP/PowershellTranscript2.txt" -Raw | Split-String "_ ➜"  | foreach {"hello: " + $_.Trim()} | Where-Object {$_ -ne ""}
    # $Promt
    # $Promt | Select-Object -Last 2 | Select-Object -Index 1
    #ollama run zephyr:latest "$BasePromt" + "'$Promt'"
}


Set-Alias -Name jo -Value jira_open
Set-Alias -Name jp -Value jira_progress
