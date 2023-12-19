
# Prereqs

#choco install ripgrep
#choco install fzf
#choco install bat
#choco install zoxide
#choco install highlight
#choco install vifm
#winget install eza-community.eza
#pip install --upgrade betterls
#dotnet tool install --global csharp-ls

#set env variable "editor" to "nvim
#add C:\Program Files\Highlight to path

#Powershell
#Install-Module PSUtil # https://github.com/PowershellFrameworkCollective/PSUtil
#Install-Module -Name PSFzf
#Install-Module PSReadLine

#Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

#choco install starship
#choco install sysinternals

# Dotfiles
#git clone https://github.com/NvChad/NvChad $HOME\AppData\Local\nvim --depth 1
#rm $HOME\AppData\Local\nvim\lua\custom # We link our own custom lua here from dotfiles later

# Clone dotfiles repo
$dotFilesRoot = Join-Path $HOME "dotfiles"

if (!(Test-Path $dotFilesRoot -PathType Container)) {
    git clone https://github.com/Johanw123/dotfiles.git $dotFilesRoot
}


# link NeoVim configuration
$localConfiguration = Join-Path "$env:LOCALAPPDATA" -ChildPath "nvim" | Join-Path -ChildPath "lua" | Join-Path -ChildPath "custom"
$dotfilesConfiguration = Join-Path "$dotFilesRoot" -ChildPath ".config" | Join-Path -ChildPath "nvim" | Join-Path -ChildPath "lua" | Join-Path -ChildPath "custom"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}

# link Omnisharp configuration
$localConfiguration = Join-Path $HOME ".omnisharp"
$dotfilesConfiguration = Join-Path $dotFilesRoot ".omnisharp"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}

# link Powershell configuration
$localConfiguration = Join-Path $HOME "Documents" | Join-Path -ChildPath "PowerShell" | Join-Path -ChildPath "Microsoft.PowerShell_profile.ps1"
$dotfilesConfiguration = Join-Path $dotFilesRoot "Powershell" | Join-Path -ChildPath "Microsoft.PowerShell_profile.ps1"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}

# link LSD configuration
$localConfiguration = Join-Path $env:APPDATA "lsd"
$dotfilesConfiguration = Join-Path $dotFilesRoot "lsd"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}

# link windows terminal configuration
$localConfiguration = Join-Path $env:LOCALAPPDATA "Packages" | Join-Path -ChildPath "Microsoft.WindowsTerminal_8wekyb3d8bbwe" | Join-Path -ChildPath "LocalState"
$dotfilesConfiguration = Join-Path $dotFilesRoot "windows_terminal" | Join-Path -ChildPath "LocalState"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}

# link wezterm configuration
$localConfiguration = Join-Path $HOME ".wezterm.lua"
$dotfilesConfiguration = Join-Path $dotFilesRoot "wezterm" | Join-Path -ChildPath ".wezterm.lua"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}

# link Vifm configuration
$localConfiguration = Join-Path $env:APPDATA "Vifm"
$dotfilesConfiguration = Join-Path $dotFilesRoot "Vifm"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}

# link starship configuration
$localConfiguration = Join-Path $HOME ".config" | Join-Path -ChildPath "starship.toml"
$dotfilesConfiguration = Join-Path $dotFilesRoot "starship" | Join-Path -ChildPath "starship.toml"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}