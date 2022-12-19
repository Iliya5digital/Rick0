@ECHO off
pushd "%~dp0"
echo Checando Permissoes...
if not "%1"=="am_admin" ("%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" start -verb runas '%0' am_admin & exit /b)
CLS
ECHO ENCERRANDO PROCESSOS...
tasklist | find /i "chrome.exe" && taskkill /im "chrome.exe" /F >nul &cls
tasklist | find /i "googleupdate.exe" && taskkill /im "googleupdate.exe" /F >nul &cls
TITLE LIMPEZA DE ARQUIVOS TEMPORARIOS TODOS USUARIOS BY RICK
cls
for /f %%a in ('dir %SYSTEMDRIVE%\users /O-D /B /A:D-S-H') do (
if exist "%SYSTEMDRIVE%\users\%%a\AppData\Local\Temp"  rd "%SYSTEMDRIVE%\users\%%a\AppData\Local\Temp" /s /q & IF NOT EXIST "%SYSTEMDRIVE%\users\%%a\AppData\Local\Temp" MD "%SYSTEMDRIVE%\users\%%a\AppData\Local\Temp" >nul
if exist "%SYSTEMDRIVE%\users\%%a\AppData\Local\Google\Chrome\User Data\Default\Cache" rd "%SYSTEMDRIVE%\users\%%a\AppData\Local\Google\Chrome\User Data\Default\Cache" /s /q >nul
if exist "%SYSTEMDRIVE%\users\%%a\AppData\Local\Google\Chrome\User Data\Default\*history*.*" del "%SYSTEMDRIVE%\users\%%a\AppData\Local\Google\Chrome\User Data\Default\*history*.*" /s /q >nul
if exist "%SYSTEMDRIVE%\users\%%a\AppData\Local\Google\Chrome\User Data\Default\*History Provider Cache*.*" del "%SYSTEMDRIVE%\users\%%a\AppData\Local\Google\Chrome\User Data\Default\*History Provider Cache*.*" /s /q >nul
if exist "%SYSTEMDRIVE%\users\%%a\AppData\Local\Google\Chrome\User Data\Default\*cookies*.*" del "%SYSTEMDRIVE%\users\%%a\AppData\Local\Google\Chrome\User Data\Default\*cookies*.*" /s /q >nul
) 
rd  "%systemdrive%\$Recycle.bin" /s /q >nul
cls
echo .::Procurando Tarefas Agendadas Chrome::.
for /f "tokens=2 delims=\" %%x in ('schtasks /query /fo:list ^| findstr ^^GoogleUpdateTask') do SCHTASKS /End /TN "%%x" >nul && SCHTASKS /Delete /TN "%%x" /F >nul
echo .::Procurando tarefa agendada de Feed::.
for /f "tokens=2 delims=\" %%x in ('schtasks /query /fo:list ^| findstr ^^User_Feed_Synchronization') do SCHTASKS /End /TN "%%x" >nul && SCHTASKS /Delete /TN "%%x" /F >nul
echo .::Procurando Tarefas Adobe::.
for /f "tokens=2 delims=\" %%x in ('schtasks /query /fo:list ^| findstr ^^Adobe') do SCHTASKS /End /TN "%%x" >nul && SCHTASKS /disable /TN "%%x" /F >nul

cls
::DESABILITANDO SERVICOS
SET "disable_services=gupdatem,GoogleChromeElevationService,gusvc,gupdate"
for %%i in (%disable_services%) do (
SC query %%i | FIND /i "STOPPED" >nul & IF ERRORLEVEL 1 SC stop %%i >nul
SC config %%i start= disabled >nul
)
PAUSE
EXIT