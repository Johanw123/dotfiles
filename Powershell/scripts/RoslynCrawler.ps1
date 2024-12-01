$file = New-Guid
Invoke-WebRequest https://github.com/Crashdummyy/roslynLanguageServer/releases/latest/download/microsoft.codeanalysis.languageserver.win-x64.zip -OutFile ~/Downloads/$file.zip
Expand-Archive ~/Downloads/$file.zip -DestinationPath ~/AppData/Local/nvim-data/roslyn/ -Force
rm ~/Downloads/$file.zip