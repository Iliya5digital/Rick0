@echo off
setlocal EnableDelayedExpansion
TITLE VALIDANDO INTERNET EXPLORER
pushd "%~dp0"
if not "%1"=="am_admin" (%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe start -verb runas '%0' am_admin & exit /b)
POPD
SET "X86=%PROGRAMFILES%\Internet Explorer\iexplore.exe"
SET "X64=%PROGRAMFILES(X86)%\Internet Explorer\iexplore.exe"
IF %PROCESSOR_ARCHITECTURE% EQU AMD64 (GOTO X64) ELSE (GOTO X32)
:X32
::VALIDANDO INTERNET EXPLORER
for /f %%d in ('%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe -c "[System.Diagnostics.FileVersionInfo]::GetVersionInfo('%X86%').FileVersion"') do SET VERS=%%d
SET "VER=%VERS:~0,4%"
IF %VER% EQU 8.00 (goto END)
IF %VER% NEQ 8.00 (goto DOWNGRADE) 

:X64
::VERIFICA VERSAO DO IE
for /f %%d in ('%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe -c "[System.Diagnostics.FileVersionInfo]::GetVersionInfo('%X64%').FileVersion"') do SET VERS=%%d
SET VER=%VERS:~0,4%
IF %VER% EQU 8.00 (goto END)
IF %VER% NEQ 8.00 (goto DOWNGRADE)

:DOWNGRADE
SET "KILL=iexplore.exe,msiexec.exe,pkgmgr.exe"
for %%i in (%KILL%) do (
tasklist | find /i "%%i" && taskkill /im "%%i" /F >nul &CLS
)
::REMOVENDO INTERNET EXPLORER QUE SEJA DIFERENTE DO 8
FORFILES /P %WINDIR%\servicing\Packages /M Microsoft-Windows-InternetExplorer-*%VER%*.mum /c "cmd /c echo Desinstalando o @fname && start /w pkgmgr /up:@fname /quiet /norestart" 2>nul 
GOTO END
:END
::DESATIVANDO WINDOWS UPDATE
SC query "wuauserv" | FIND /i "STOPPED" >nul & IF ERRORLEVEL 1 SC stop "wuauserv" >nul & SC config "wuauserv" start= disabled >nul
POPD
EXIT