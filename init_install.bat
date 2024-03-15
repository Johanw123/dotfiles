
winget install --id Microsoft.Powershell --source winget
winget install -e --id Microsoft.VisualStudioCode
winget install chocolatey

call refresh_env.bat

powershell -File "install_admin.ps1"