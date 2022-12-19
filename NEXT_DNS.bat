@echo off
SET "NAMEDNS=NEXT DNS"
SET "IPV4DNS1=45.90.28.109"
SET "IPV4DNS2=45.90.30.109"
SET "IPV6DNS1=2a07:a8c0::e8:1eb7"
SET "IPV6DNS2=2a07:a8c1::e8:1eb7"
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