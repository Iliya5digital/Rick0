@echo off
setlocal EnableDelayedExpansion
TITLE CORRIGINDO ERRO DE IMPRESSAO 0x0000011b AGUARDE...
pushd "%~dp0"
if not "%1"=="am_admin" (%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe start -verb runas '%0' am_admin & exit /b)
POPD
REG ADD "HKLM\System\CurrentControlSet\Control\Print" /f /v "RpcAuthnLevelPrivacyEnabled" /t REG_DWORD /d "1" >NUL
ECHO CORRECAO APLICADA COM SUCESSO...
TIMEOUT 2
EXIT