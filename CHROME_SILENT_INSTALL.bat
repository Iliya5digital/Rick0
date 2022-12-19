@echo off
::pushd "%~dp0"
SET "X86=%PROGRAMFILES%\Google\Chrome\Application\chrome.exe"
SET "X64=%PROGRAMFILES(X86)%\Google\Chrome\Application\chrome.exe"
::INFORME AQUI O CAMINHO DO INSTALADOR DO CHROME E A VERSAO
SET "VERSAO=78"
SET "ORIGEM=\\servidor\caminho\Chrome\googlechrome%VERSAO%.msi"
SET "DESTINO=%SYSTEMDRIVE%\APP\googlechrome%VERSAO%.msi"

IF %PROCESSOR_ARCHITECTURE% EQU AMD64 ( GOTO X64) ELSE ( GOTO X32)

:X32
IF NOT EXIST "%X86%" (GOTO INSTALL)
::VERIFICA VERSAO DO CHROME
for /f %%d in ('%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe -c "[System.Diagnostics.FileVersionInfo]::GetVersionInfo('%X86%').FileVersion"') do SET VERS=%%d
SET VER=%VERS:~0,2%
IF %VER% EQU %VERSAO% (goto END)
IF %VER% NEQ %VERSAO% (goto INSTALL)

:X64
IF NOT EXIST "%X64%" (GOTO INSTALL)
::VERIFICA VERSAO DO CHROME
for /f %%d in ('%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe -c "[System.Diagnostics.FileVersionInfo]::GetVersionInfo('%X64%').FileVersion"') do SET VERS=%%d
SET VER=%VERS:~0,2%
IF %VER% EQU %VERSAO% (goto END)
IF %VER% NEQ %VERSAO% (goto INSTALL)

:INSTALL
tasklist | find /i "chrome.exe" && taskkill /im "chrome.exe" /F >nul &cls 
tasklist | find /i "msiexec.exe" && taskkill /im "msiexec.exe" /F >nul &cls
tasklist | find /i "googleupdate.exe" && taskkill /im "googleupdate.exe" /F >nul &cls
CLS
for %%d in ("%DESTINO%") do set "APPNAME=%%~nd"
for %%d in ("%DESTINO%") do set "APP=%%~dpd"
IF NOT EXIST "%APP%" MD "%APP%"
IF NOT EXIST "%DESTINO%" copy /y "%ORIGEM%" "%APP%" >NUL
CLS
TITLE INSTALANDO %APPNAME%
echo Instalando %APPNAME% Aguarde...
IF EXIST "%DESTINO%" start /wait msiexec /i "%DESTINO%" ALLOWDOWNGRADE=1 /qn /norestart

IF %ERRORLEVEL% NEQ 0 (ECHO %COMPUTERNAME%,CHROME=%VERSAO%,ERRO=%ERRORLEVEL%,%date%-%TIME:~0,8% >>"\\servidor\LOGS\falha.txt" & goto INSTALL) ELSE (ECHO %COMPUTERNAME%,CHROME=%VERSAO%,%date%-%TIME:~0,8% >>"\\servidor\sucesso.txt" & GOTO END)

:END
::REMOVENDO TAREFAS AGENDADAS CHROME
for /f "tokens=2 delims=\" %%x in ('schtasks /query /fo:list ^| findstr ^^GoogleUpdateTask') do SCHTASKS /End /TN "%%x" >nul && SCHTASKS /Delete /TN "%%x" /F >nul
cls
::DESABILITANDO SERVICOS
SET "disable_services=gupdatem,GoogleChromeElevationService,gusvc,gupdate"
for %%i in (%disable_services%) do (
SC query %%i | FIND /i "STOPPED" >nul & IF ERRORLEVEL 1 SC stop %%i >nul
SC config %%i start= disabled >nul
)
::REMOVENDO ATALHO DO CHROME DA AREA DE TRABALHO PUBLICA
IF EXIST "%PUBLIC%\Desktop\Google Chrome.lnk" del /f /q "%PUBLIC%\Desktop\Google Chrome.lnk"
EXIT