@echo off
pushd "%~dp0"
echo Checando Permissoes...
if not "%1"=="am_admin" ("%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" start -verb runas '%0' am_admin & exit /b)
::%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&& Exit /B 1
CLS
SET "SERVICE=winmgmt"
cls
echo Configuração wmi..
::-------------------PARANDO SERVICO WMI E RENOMEANDO DIRETORIO REPOSITORY---------------:
SC query %SERVICE% | FIND /i "STOPPED" >nul & IF ERRORLEVEL 1 net stop %SERVICE% /y >nul
Echo Parando Servico %SERVICE%
SC config %SERVICE% start= disabled >nul
::CHECANDO A EXISTENCIA DO REPOSITORIO NA PASTA WBEM SE EXISTIR A PASTA REPOSITORY.OLD REMOVE
IF EXIST "%windir%\System32\wbem\repository.old" rmdir /s /q "%windir%\System32\wbem\repository.old"
IF EXIST "%windir%\System32\wbem\repository" ren "%windir%\System32\wbem\repository" "Repository.old"
::-------------------FIM PARANDO WMI E RENOMEANDO DIRETORIO REPOSITORY-------------------:

::--------CORRIGINDO SERVICO E CONFIGURANDO PARA REINICIAR EM CASO DE FALHA--------------:
SC config %SERVICE% start= auto >nul
SC query %SERVICE% | FIND /i "RUNNING" >nul & IF ERRORLEVEL 1 net start %SERVICE% /y >nul
::RESETANDO CONFIGURACOES WMI PARA QUE O SERVICO SEJA REINICIADO EM CASO DE FALHA
SC failure %SERVICE% actions= restart/60000/restart/60000// reset= 100000
::--------FIM CORRIGINDO SERVICO E CONFIGURANDO PARA REINICIAR EM CASO DE FALHA----------:
EXIT