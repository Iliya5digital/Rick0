@echo off
Echo Bloqueando virus de atalho Aguarde...
TITLE Script Bloquear virus de pendrive
pushd "%~dp0"
if not "%1"=="am_admin" ("%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" start -verb runas '%0' am_admin & exit /b)
::Desativa Windows Script Host usuario local
reg add "HKCU\Software\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d "0" /f > nul
::Desativa Windows Script Host todos usuários
reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d "0" /f > nul
::Desativa execução do script pelo explorer usuario local
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisallowRun" /t REG_DWORD /d "1" /f > nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /t REG_SZ /d "wscript.exe" /f > nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "2" /t REG_SZ /d "cscript.exe" /f > nul
::Desativa WSCRIPT e Cscript execucao pelo explorer Todos usuarios
reg load HKLM\DEFAULT %SYSTEMDRIVE%\users\default\ntuser.dat > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisallowRun" /t REG_DWORD /d "1" /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /t REG_SZ /d "wscript.exe" /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "2" /t REG_SZ /d "cscript.exe" /f > nul
reg unload HKLM\DEFAULT > nul
POPD
ECHO VIRUS DE PENDRIVE BLOQUEADO COM SUCESSO
TIMEOUT 3 
EXIT