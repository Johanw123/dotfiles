winget install --id Microsoft.Powershell --source winget
winget install chocolatey
winget install -e --id Git.Git
winget install -e --id ajeetdsouza.zoxide
winget install -e --id Starship.Starship

call refresh_env.bat

powershell -Command "Start-Process -Verb RunAs pwsh '-ExecutionPolicy Bypass -Command & \\\".\install_admin.ps1\\\"' "

exit

REM PlasticSCM-10.0.16.5710-windows-installer.exe --mode unattended --unattendedmodeui none --disable-components ideintegrations,eclipse,mylyn,intellij12 --enable-components server
