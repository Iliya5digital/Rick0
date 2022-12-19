cmd.exe /c start /min "" SC query DFServ | FIND /i "STOPPED" >nul & IF ERRORLEVEL 1  SC stop DFServ >nul & taskkill /im FrzState2k.exe /f >nul
