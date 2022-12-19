@ECHO off
TITLE INSTALANDO KB FIM HORARIO DE VERAO By Rick
::SE FOR RODAR O SCRIPT LOCALMENTE DEIXE HABILITADO SE FOR RODAR POR SCRIPT DE DOMINIO DESABILITE AS OPCOES ABAIXO
pushd "%~dp0"
echo Checando Permissoes...
if not "%1"=="am_admin" ("%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" start -verb runas '%0' am_admin & exit /b)
CLS
::=======INICIANDO WINDOWS UPDATE CASO ESTEJA DESABILITADO=======================:
SET "SVCNAME=wuauserv"
FOR %%a IN (%SVCNAME%) DO (SC query %%a | FIND /i "RUNNING" >nul & IF ERRORLEVEL 1 SC config %%a start= demand >nul & SC start %%a >nul)
::=======FIM INICIANDO WINDOWS UPDATE CASO ESTEJA DESABILITADO==================:

::=======ORIENTACOES E ONDE BAXAR OS KBS=======================:
::ONDE BAIXAR OS KBS E ORIENTACOES
::https://support.microsoft.com/pt-br/help/4507704/dst-changes-in-windows-for-brazil-and-morocco
::
::Windows 7, 8.1, 2008, 2008 R2 e 2012, 2012 R2
::https://www.catalog.update.microsoft.com/search.aspx?q=kb4507704
::Para Windows 10, Server 2016 e 2019 seguem:
::Windows 10 Version 1903 (May 2019 Update)
::https://support.microsoft.com/pt-br/help/4505903/windows-10-update-kb4505903
::https://www.catalog.update.microsoft.com/Search.aspx?q=KB4505903
::
::Windows 10 Version 1809 (October 2018 Update)
::https://support.microsoft.com/pt-br/help/4505658/windows-10-update-kb4505658
::https://www.catalog.update.microsoft.com/Search.aspx?q=KB4505658
::
::Windows 10 Version 1803 (April 2018 Update)
::https://support.microsoft.com/pt-br/help/4507466/windows-10-update-kb4507466
::https://www.catalog.update.microsoft.com/Search.aspx?q=KB4507466
::
::Windows 10 Version 1709 (Fall Creators Update)
::https://support.microsoft.com/pt-br/help/4507465/windows-10-update-kb4507465
::https://www.catalog.update.microsoft.com/Search.aspx?q=KB4507465
::
::Windows 10 Version 1703 (Creators Update)
::https://support.microsoft.com/be-by/help/4507467/windows-10-update-kb4507467
::https://www.catalog.update.microsoft.com/Search.aspx?q=KB4507467
::
::Windows 10 Version 1607 (Anniversary Update)
::https://support.microsoft.com/pt-br/help/4507459/windows-10-update-kb4507459
::https://www.catalog.update.microsoft.com/Search.aspx?q=KB4507459

::=======DOWNLOAD KBS SCRIPT POWERSHELL=======================:
::SCRIPT EM POWERSHELL PARA DOWNLOAD DAS VERSOES (WINDOWS 7,8,8.1 E WINDOWS 10 do 1607 ao 1903)
::https://pastebin.com/qbMc0zYF
::OBS PARA O SCRIPT INDENTIFICAR O KB CORRETAMENTE NAO ALTERE 
::O QUE VEM ANTES DA_ PARA RENOMEAR OS KBS DA PASTA
::USE O COMANDO ABAIXO NO TERMINAL NA PASTA DOS KBS PARA RENOMEA-LOS CORRETAMENTE
::FOR /F "tokens=1* delims=_" %E in ('dir /B /A:-D "*_*.*"') do ren "%E_%F" "%E.*"
::SE FOR USA EM SCRIPT BAT USE %% ANTES DE CADA VARIAVEL EX:
::@ECHO OFF
::FOR /F "tokens=1* delims=_" %%E in ('dir /B /A:-D "*_*.*"') do ren "%%E_%%F" "%%E.*"
::EXIT
::============================================================:

::=======INDENTIFICANDO O SISTEMA OPERACIONAL=================:
::SE FOR USAR EM
::VERSOES BUILDS
::Windows 10 (1903)-10.0.18362
::Windows 10 (1809)-10.0.17763
::Windows 10 (1803)-10.0.17134
::Windows 10 (1709)-10.0.16299
::Windows 10 (1703)-10.0.15063
::Windows 10 (1607)-10.0.14393
::Windows 10-(1 VERSAO)- 10.0.10240
::Windows 8 Windows 8.1 (Update 1) 	6.3.9600
::Windows 8.1 6.3.9200
::Windows 7 Windows 7 SP1 	6.1.7601
::======= FIM INDENTIFICANDO O SISTEMA OPERACIONAL============:

::======= VALIDANDO SISTEMA OPERACIONAL============:
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(IF %%i==Version (set VERSION=%%j.%%k.%%l) else (set VERSION=%%i.%%j.%%k))
IF "%VERSION%" == "10.0.18362" SET "KB=*KB4505903"
IF "%VERSION%" == "10.0.17763" SET "KB=*KB4505658"
IF "%VERSION%" == "10.0.17134" SET "KB=*KB4507466"
IF "%VERSION%" == "10.0.16299" SET "KB=*KB4507465"
IF "%VERSION%" == "10.0.15063" SET "KB=*KB4507467"
IF "%VERSION%" == "10.0.14393" SET "KB=*KB4507459"
IF "%VERSION%" == "6.3.9600"   SET "KB=*windows8.1*KB4507704"
IF "%VERSION%" == "6.3.9200"   SET "KB=*windows8.1*KB4507704"
IF "%VERSION%" == "6.1.7601"   SET "KB=*windows6.1*KB4507704"
IF NOT DEFINED KB ECHO NENHUM SISTEMA COMPATIVEL & GOTO END

::INFORME A PASTA QUE CONTEM OS KBS A SEREM INSTALADOS NAO COLOQUE \ NO FINAL
SET "PATCH=\\SERVIDOR\CAMINHO\KB"

::CAMINHO ONDE O KB SERA COPIADO NAO COLOQUE \ NO FINAL
SET "LPATCH=%SYSTEMDRIVE%\KB"

::CRIANDO A PASTA KB CASO NAO EXISTA
IF NOT EXIST "%LPATCH%" md "%LPATCH%" >nul

::VALIDANDO SE E 64 OU 32 BITS E SETANDO VARIAVEL PARA A PASTA TEMPORARIA PARA EXTRACAO DOS KBS
IF %PROCESSOR_ARCHITECTURE% EQU AMD64 (SET "TMPKB=TEMP64" & goto X64) ELSE (SET "TMPKB=TEMP32" & goto X86)

:X64
IF EXIST "%LPATCH%\*.msu" (DEL /F /S /Q "%LPATCH%\*.msu") >nul
IF EXIST "%LPATCH%\%TMPKB%\*.*" (RMDIR /S /Q "%LPATCH%\%TMPKB%\") >nul
ECHO COPIANDO KB AGUARDE...
IF NOT EXIST "%LPATCH%\%KB%*x64*.msu" copy /y  "%PATCH%\%KB%*x64*.msu" "%LPATCH%\" 2>nul
for /F %%i in ('dir "%LPATCH%\%KB%*x64*.msu" /O-D /B /A:-D') do set CABX=%%i
CLS
TITLE  EXTRAINDO "%CABX%"
IF NOT EXIST "%LPATCH%\%TMPKB%\" MD "%LPATCH%\%TMPKB%\" >nul
IF EXIST "%LPATCH%\%KB%*x64*.msu" expand -f:* "%LPATCH%\%KB%*x64*.msu" "%LPATCH%\%TMPKB%" 2>nul
for /F %%i in ('dir "%LPATCH%\%TMPKB%\%KB%*x64*.cab" /O-D /B /A:-D') do set CAB=%%i
CLS
TITLE Instalando %CAB% Aguarde...
START /wait DISM.exe /Online /Add-Package /PackagePath:"%LPATCH%\%TMPKB%\%CAB%" /quiet /NORESTART 2>nul
ECHO Realizando limpeza
IF EXIST "%LPATCH%\%KB%*x64*.msu" del "%LPATCH%\%KB%*x64*.msu" /f /Q >nul
IF EXIST "%LPATCH%\%TMPKB%" RMDIR "%LPATCH%\%TMPKB%" /S /Q >nul
GOTO END

:X86
IF EXIST "%LPATCH%\*.msu" (DEL /F /S /Q "%LPATCH%\*.msu") >nul
IF EXIST "%LPATCH%\%TMPKB%\*.*" (RMDIR /S /Q "%LPATCH%\%TMPKB%\") >nul
ECHO COPIANDO %KB% AGUARDE...
IF NOT EXIST "%LPATCH%\%KB%*x86*.msu" copy /y  "%PATCH%\%KB%*x86*.msu" "%LPATCH%\" 2>nul
for /F %%i in ('dir "%LPATCH%\%KB%*x86*.msu" /O-D /B /A:-D') do set CABX=%%i
CLS
TITLE  EXTRAINDO "%CABX%"
IF NOT EXIST "%LPATCH%\%TMPKB%\" MD "%LPATCH%\%TMPKB%\" >nul
IF EXIST "%LPATCH%\%KB%*x86*.msu" expand -f:* "%LPATCH%\%KB%*x86*.msu" "%LPATCH%\%TMPKB%" >nul
for /F %%i in ('dir "%LPATCH%\%TMPKB%\%KB%*x86*.cab" /O-D /B /A:-D') do set CAB=%%i
CLS
TITLE Instalando %CAB% Aguarde...
START /wait DISM.exe /Online /Add-Package /PackagePath:"%LPATCH%\%TMPKB%\%CAB%" /quiet /NORESTART 2>nul
ECHO Realizando limpeza
IF EXIST "%LPATCH%\%KB%*x86*.msu" del "%LPATCH%\%KB%*x86*.msu" /f /Q >nul
IF EXIST "%LPATCH%\%TMPKB%" RMDIR "%LPATCH%\%TMPKB%" /S /Q >nul
GOTO END

:END
EXIT