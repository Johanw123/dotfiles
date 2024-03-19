Function CheckRunAsAdministrator()
{
  #Get current user context
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  
  #Check user is running the script is member of Administrator Group
  if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
  {
       Write-host "Script is running with Administrator privileges!"
  }
  else
    {
       #Create a new Elevated process to Start PowerShell
       $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
 
       # Specify the current script path and name as a parameter
       $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
 
       #Set the Process to elevated
       $ElevatedProcess.Verb = "runas"
 
       #Start the new elevated process
       [System.Diagnostics.Process]::Start($ElevatedProcess)
 
       #Exit from the current, unelevated, process
       Exit
 
    }
}

Function TryCreateLink([string]$a, [string]$b)
{
    if (!(Test-Path $a)) { 
        New-Item -Path $a -ItemType SymbolicLink -Value $b
    }
    else{
        Write-Host "Link to $a exists"
    }
}

Function TryAddFont($Font)
{
    $path = Join-Path "C:\Windows\Fonts\" $Font.Name
    if (!(Test-Path $path)) { 
        Write-Host 'Installing font -' $Font.BaseName
        Copy-Item $Font "C:\Windows\Fonts"
        New-ItemProperty -Name $Font.BaseName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $Font.name 
    }
    else{
        Write-Host "The font '$Font' is already installed"
    }
}
 
#Check Script is running with Elevated Privileges
#CheckRunAsAdministrator

$dotFilesRoot = Join-Path $HOME "dotfiles"

Set-Location $dotFilesRoot

winget install --id=Neovim.Neovim  -e
winget install wez.wezterm
winget install -e --id Microsoft.WindowsTerminal
winget install eza-community.eza
winget install -e --id dotPDNLLC.paintdotnet
winget install -e --id 7zip.7zip

winget install Microsoft.DotNet.SDK.8
winget install -e --id SlackTechnologies.Slack
winget install -e --id Microsoft.VisualStudioCode

# Command line programs
choco install ripgrep -y
choco install fzf -y
choco install bat -y
choco install zoxide -y
choco install highlight -y
choco install vifm -y

choco install starship -y
choco install sysinternals -y

#Powershell Plugins
#https://github.com/PowershellFrameworkCollective/PSUtil


if (-not (Get-Module PSUtil -ListAvailable)){
    Install-Module PSUtil -Force
}

if (-not (Get-Module PSReadLine -ListAvailable)){
    Install-Module PSReadLine -Force
}

if (-not (Get-Module PSFzf -ListAvailable)){
    Install-Module PSFzf -Force
}


Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# real vnc
winget install --id=RealVNC.VNCServer  -e

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

if (!(Test-Path $dotFilesRoot -PathType Container)) {
    git clone https://github.com/Johanw123/dotfiles.git $dotFilesRoot
}

if (!(Test-Path -Path "$env:LOCALAPPDATA\nvim" -PathType Container)) {
    git clone https://github.com/NvChad/NvChad --branch v2.0 $HOME\AppData\Local\nvim --depth 1
} 

if (Test-Path -Path "$HOME\AppData\Local\nvim\lua\custom" -PathType Container) {
    # We link our own custom lua here from dotfiles later
    rm $HOME\AppData\Local\nvim\lua\custom -r -force
}

if (Test-Path -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -PathType Container) {
    # We link our own powershell local state
    rm $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -r -force
}

TryCreateLink "$env:LOCALAPPDATA\nvim\lua\custom" "$dotFilesRoot\.config\nvim\lua\custom"
TryCreateLink "$HOME\.omnisharp" "$dotFilesRoot\.omnisharp"
TryCreateLink "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" "$dotFilesRoot\Powershell\Microsoft.PowerShell_profile.ps1"
TryCreateLink "$env:APPDATA\lsd" "$dotFilesRoot\lsd"
TryCreateLink "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" "$dotFilesRoot\windows_terminal\LocalState"
TryCreateLink "$HOME\.wezterm.lua" "$dotFilesRoot\wezterm\.wezterm.lua"
TryCreateLink "$env:APPDATA\Vifm" "$dotFilesRoot\Vifm"
TryCreateLink "$HOME\.config\starship.toml" "$dotFilesRoot\starship\starship.toml"
TryCreateLink "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\keep_wsl_alive.vbs" "$dotFilesRoot\keep_wsl_alive.vbs"
TryCreateLink "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\remove_intune.bat" "$dotFilesRoot\work/remove_intune.bat"
TryCreateLink "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\remove_intune.ps1" "$dotFilesRoot\work/remove_intune.ps1"

#Fonts
$FontFolder = "fonts"
$FontItem = Get-Item -Path $FontFolder
$FontList = Get-ChildItem -Path "$FontItem\*" -Include ('*.fon','*.otf','*.ttc','*.ttf')

foreach ($Font in $FontList) {
    TryAddFont $Font        
}


# Work 
winget install --id=Microsoft.VisualStudio.2022.Professional  -e
winget install Microsoft.VisualStudio.2022.BuildTools
winget install Microsoft.VCRedist.2015+.x64
winget install Microsoft.VCRedist.2015+.x86
winget install --id=Nvidia.CUDA -v "12.2.2" -e


# Windows 11 Settings
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0 -Force
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force

& ".\install_nvidia_drivers.ps1"


# WSL
# Enable Needed Virtualization
#dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
#dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

#wsl.exe --install --d Ubuntu-22.04
