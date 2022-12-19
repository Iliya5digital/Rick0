@echo off
echo liberar acesso remoto
::=======INICIANDO AREA DE TRABALHO REMOTA CASO ESTEJA DESABILITADO=======================:
SET "SVCNAME=RemoteAccess"
SC config "%SVCNAME%" start= demand >nul & SC start "%SVCNAME%" >nul
::=======FIM AREA DE TRABALHO REMOTA CASO ESTEJA DESABILITADO=============================:
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
exit