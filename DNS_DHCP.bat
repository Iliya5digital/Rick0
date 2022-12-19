@echo off
TITLE ATIVANDO DNS DHCP
echo Checando Permissoes...
SET "PSW=%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe"
SETLOCAL EnableDelayedExpansion
pushd "%~dp0"
if not "%1"=="am_admin" ("%PSW%" start -verb runas '%0' am_admin & exit /b)
::PROCURA PLACA DE REDE ATIVA E RETORNA SOMENTE A PRIMEIRA QUE ESTA CONECTADA
for /f %%d in ('%PSW% -c "(gwmi win32_networkadapter -Property NetConnectionID,NetConnectionStatus | ? { $_.NetConnectionStatus -eq 2 } | Select-Object -Property NetConnectionID -ExpandProperty NetConnectionID).Split([environment]::newline)[0]"') do (set "CON=%%d")

CLS & ECHO ATIVANDO DNS DHCP IPV4 AUTOMATICO
::IPV4
netsh int ipv4 set dns "%CON%" source=dhcp validate=no
TIMEOUT 2 & CLS

ECHO ATIVANDO DNS DHCP IPV6 AUTOMATICO
::IPV6
netsh int ipv6 set dns "%CON%" source=dhcp validate=no
TIMEOUT 2 & CLS 
ECHO ATUALIZANDO CONFIGURACAO DNS
ipconfig /flushdns >nul
TIMEOUT 2 & CLS 
POPD
ENDLOCAL
EXIT