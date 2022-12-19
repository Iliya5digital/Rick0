@echo off
SET "NAMEDNS=DNS CLOUDFLARE"
SET "IPV4DNS1=1.1.1.2"
SET "IPV4DNS2=1.0.0.2"
SET "IPV6DNS1=2606:4700:4700::1112"
SET "IPV6DNS2=2606:4700:4700::1002"
SET "PSW=%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe"
TITLE ALTERANDO %NAMEDNS%
echo Checando Permissoes...
SETLOCAL EnableDelayedExpansion
pushd "%~dp0"
if not "%1"=="am_admin" ("%PSW%" start -verb runas '%0' am_admin & exit /b)
::PROCURA PLACA DE REDE ATIVA E RETORNA SOMENTE A PRIMEIRA QUE ESTA CONECTADA
for /f %%d in ('%PSW% -c "(gwmi win32_networkadapter -Property NetConnectionID,NetConnectionStatus | ? { $_.NetConnectionStatus -eq 2 } | Select-Object -Property NetConnectionID -ExpandProperty NetConnectionID).Split([environment]::newline)[0]"') do (set "CON=%%d")
CLS & ECHO ATIVANDO %NAMEDNS% IPV4
::IPV4
netsh int ipv4 set dns name="%CON%" static %IPV4DNS1% primary validate=no
netsh int ipv4 add dns name="%CON%" %IPV4DNS2% index=2 validate=no
TIMEOUT 2 & CLS
ECHO ATIVANDO %NAMEDNS% IPV6
::IPV6
netsh int ipv6 set dns name="%CON%" static %IPV6DNS1% primary validate=no
netsh int ipv6 add dns name="%CON%" %IPV6DNS2% index=2 validate=no
TIMEOUT 2 & CLS 
ECHO ATUALIZANDO CONFIGURACAO DNS
ipconfig /flushdns >nul
TIMEOUT 2 & CLS 
POPD
ENDLOCAL
EXIT