@echo off
setlocal EnableDelayedExpansion
pushd "%~dp0"
IF %PROCESSOR_ARCHITECTURE% EQU AMD64 (SET "VPN=%PROGRAMFILES(X86)%\Fortinet\FortiClient") ELSE (SET "VPN=%PROGRAMFILES%\Fortinet\FortiClient")
SET "CONF=%VPN%\FCConfig.exe"
SET "FCLI=%VPN%\Forticlient.exe"
::CAMINHO ARQUIVO EXPORTADO=PASTA ATUAL
SET "FVPN=%~dp0CONFIGVPN"
::EXPORTANDO CONFIGURACAO VPN E SETANDO UMA SENHA 
::REMOVENDO A OPCAO export -p "senhavpn45*" exporta a configuracao sem senha
IF EXIST "%FCLI%" (start "" "%FCLI%")
IF EXIST "%CONF%" ("%CONF%" -f "%FVPN%" -m all -o export -p "senhavpn45*" & tasklist | find /i "Forticlient.exe" && taskkill /im "Forticlient.exe" /F >nul &CLS)
POPD
EXIT