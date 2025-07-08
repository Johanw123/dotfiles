taskkill /f /fi "WINDOWTITLE eq YasbBar"
cmd /c start /min "" komorebic stop
taskkill /f /im "whkd.exe"
cmd /c start /min "" komorebic start --whkd --bar