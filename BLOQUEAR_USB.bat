@echo off
TITLE BLOQUEAR USB
ECHO BLOQUEANDO USB AGUARDE...
setlocal EnableDelayedExpansion
pushd "%~dp0"
if not "%1"=="am_admin" (%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe start -verb runas '%0' am_admin & exit /b)
REG ADD "HKCU\Software\Policies\Microsoft\Windows\RemovableStorageDevices" /v "Deny_All" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices" /v "Deny_All" /t REG_DWORD /d 1 /f > nul
ECHO Bloqueio efetuado Aperte uma tecla para fazer logoff...
PAUSE
shutdown /l /f
::logoff
POPD
EXIT