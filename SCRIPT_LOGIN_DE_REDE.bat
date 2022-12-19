@echo off
setlocal EnableDelayedExpansion
TITLE SCRIPT LOGINS DE REDE
pushd "%~dp0"
CLS
ECHO LENDO LISTA.txt E SALVANDO NO ARQUIVO LOGINS.txt AGUARDE...
IF EXIST "%~dp0LOGINS.txt" del /f /q "%~dp0LOGINS.txt"
for /f "tokens=1* delims=" %%G in (LISTA.txt) do (
   for /f "tokens=1* delims=" %%a in ('dsquery user -name "%%G"^ "OU=XXXX,OU=XXXX,DC=SERVIDOR,DC=com,DC=br"^|dsget user -samid ^| find /v "samid" ^| find /v "dsget"') do (
      SET "_USER=%%a"
	  SET USER=!_USER: =!
   )
   ECHO %%G,!USER!>>LOGINS.txt
   SET "USER="
)
CLS
ECHO CONCLUIDO...
popd
::explorer "%~dp0"
EXIT