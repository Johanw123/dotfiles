$file = New-Guid
Invoke-WebRequest https://github.com/Crashdummyy/roslynLanguageServer/releases/latest/download/microsoft.codeanalysis.languageserver.linux-x64.zip -OutFile ~/Downloads/$file.zip
Expand-Archive ~/Downloads/$file.zip -DestinationPath ~/.local/share/nvim/roslyn -Force
rm ~/Downloads/$file.zip
