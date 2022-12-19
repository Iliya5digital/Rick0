@ECHO OFF
setlocal EnableDelayedExpansion
pushd "%~dp0"
SET "USER=USUARIO"
SET "PASS=SENHA"
SET "LOGS=LOG_PC.txt"
::if not "%1"=="am_admin" ("%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" start -verb runas '%0' am_admin & exit /b)
::IGNORAR ERRO DE CERTIFICADO
REG ADD "HKLM\SOFTWARE\SOFTWARE\Microsoft\Terminal Server Client" /f /v "AuthenticationLevelOverride" /t REG_DWORD /d 0 >nul
::LIMPA LOGS_ANTIGOS
IF EXIST "%~dp0%LOGS%" del /f /q "%~dp0%LOGS%" 2>nul&cls
for /f "delims=*" %%A in (%~dp0maquinas.txt) do (
(ping -n 1 %%A 2>nul | findstr "TTL")&& (TITLE CONECTANDO A %%A && echo CONECTANDO A %%A AGUARDE... && cmdkey /generic:TERMSRV/%%A /user:%USER% /pass:%PASS% >nul && mstsc /v:%%A >nul && pause &&  cmdkey /delete:TERMSRV/%%A >nul && ECHO %%A,OK>>%~dp0%LOGS%) || (TITLE CONECTANDO A %%A && echo FALHA NA CONEXAO %%A & ECHO %%A,FALHA>>%~dp0%LOGS%)
)
popd
EXIT