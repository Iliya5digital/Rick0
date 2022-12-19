@echo off
setlocal EnableDelayedExpansion
pushd "%~dp0"
IF %PROCESSOR_ARCHITECTURE% EQU AMD64 (SET "VPN=%PROGRAMFILES(X86)%\Fortinet\FortiClient") ELSE (SET "VPN=%PROGRAMFILES%\Fortinet\FortiClient")
SET "CONF=%VPN%\FCConfig.exe"
SET "FCLI=%VPN%\Forticlient.exe"
::CAMINHO IMPORTANDO ARQUIVO=PASTA ATUAL
SET "FVPN=%~dp0CONFIGVPN"
::REMOVENDO A OPCAO import -p "senhavpn45*" importa a configuracao sem senha
IF EXIST "%FCLI%" (start "" "%FCLI%" & tasklist | find /i "Forticlient.exe" && taskkill /im "Forticlient.exe" /F >nul &CLS)
IF EXIST "%CONF%" ("%CONF%" -f "%FVPN%" -m all -o import -p "senhavpn45*" & if exist "%FVPN%" del /f /q "%FVPN%" & start "" "%FCLI%")
POPD
ENDLOCAL
EXIT