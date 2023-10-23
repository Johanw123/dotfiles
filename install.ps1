
# Prereqs

#choco install ripgrep
#choco install fzf
#dotnet tool install --global csharp-ls

#Powershell
#Install-Module PSUtil # https://github.com/PowershellFrameworkCollective/PSUtil
#choco install starship

# Dotfiles
#git clone https://github.com/NvChad/NvChad $HOME\AppData\Local\nvim --depth 1
#rm $HOME\AppData\Local\nvim\lua\custom # We link our own custom lua here from dotfiles later

# Clone dotfiles repo
$dotFilesRoot = Join-Path $HOME "dotfiles"

if (!(Test-Path $dotFilesRoot -PathType Container)) {
    git clone https://github.com/Johanw123/dotfiles.git $dotFilesRoot
}


# link NeoVim configuration
$localConfiguration = Join-Path $env:LOCALAPPDATA "nvim" "lua" "custom"
$dotfilesConfiguration = Join-Path $dotFilesRoot ".config" "nvim" "lua" "custom"

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
$localConfiguration = Join-Path $HOME "Documents" "PowerShell" "Microsoft.PowerShell_profile.ps1"
$dotfilesConfiguration = Join-Path $dotFilesRoot "Powershell" "Microsoft.PowerShell_profile.ps1"

if (!(Test-Path $localConfiguration -PathType Container)) { 
    Start-Process -FilePath "pwsh" -ArgumentList "-c New-Item -Path $localConfiguration -ItemType SymbolicLink -Value $dotfilesConfiguration".Split(" ") -Verb runas
}