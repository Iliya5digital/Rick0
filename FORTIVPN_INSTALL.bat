@echo off
TITLE INSTALANDO FORTICLIENT VPN
SET "DESTINO=%SYSTEMDRIVE%\Suporte\instaladorvpn.exe"
IF %PROCESSOR_ARCHITECTURE% EQU AMD64 (SET "ORIGEM=\\servidor\pasta\instaladorvpnX64.exe" & SET "VPN=%PROGRAMFILES(X86)%\Fortinet\FortiClient\FortiClient.exe") ELSE (SET "ORIGEM=\\servidor\pasta\instaladorvpnX32.exe" & SET "VPN=%PROGRAMFILES%\Fortinet\FortiClient\FortiClient.exe")
IF NOT EXIST "%VPN%" (GOTO INSTALL) ELSE (GOTO END)
:INSTALL
tasklist | find /i "msiexec.exe" && taskkill /im "msiexec.exe" /F >nul &CLS
IF NOT EXIST "%DESTINO%" (echo f|xcopy /R /S /H /D /V /Y /O /F "%ORIGEM%" "%DESTINO%" >nul & cls)
::INSTALANDO VPN
ECHO INSTALANDO CLIENTE VPN AGUARDE...
IF EXIST  "%DESTINO%" "%DESTINO%" /quiet /norestart
::LOGS INSTALAÇÃO VPN
IF %ERRORLEVEL% NEQ 0 (ECHO %COMPUTERNAME%,VPN=FORTCLIENT,ERRO=%ERRORLEVEL%,%date%-%TIME:~0,8% >>"\\servidor\pasta\logvpn\falha.txt" & goto INSTALL) ELSE (ECHO %COMPUTERNAME%,VPN=FORTICLIENT,%date%-%TIME:~0,8% >>"\\servidor\pasta\logvpn\sucesso.txt" & GOTO END)
:END
EXIT