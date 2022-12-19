@echo off
Echo Ativando Windows Script HOST Aguarde...
TITLE Script Ativar WINDOWS SCRIPT HOST
pushd "%~dp0"
if not "%1"=="am_admin" ("%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" start -verb runas '%0' am_admin & exit /b)
reg add "HKCU\Software\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d "1" /f
POPD
ECHO WINDOWS SCRIPT HOST ATIVADO COM SUCESSO
TIMEOUT 3 
EXIT