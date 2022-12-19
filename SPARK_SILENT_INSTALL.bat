@echo off
Title VALIDA SPARK BY Rick
ECHO CHECANDO VERSAO DO SISTEMA
pushd "%~dp0"
::SETANDO VARIAVEIS CAMINHO DO SPARK (SETTING VARIABLES SPARK WAY)
SET X64=%PROGRAMFILES(X86)%\Spark\Spark.exe
SET X32=%PROGRAMFILES%\Spark\Spark.exe
::INFORME AQUI A VERSAO A SER INSTALADA DO SPARK(INFORM HERE THE VERSION TO BE INSTALLED OF SPARK)
SET SPARK=2.8.3.960
::CHECA O SISTEMA SE 32 OU 64 BITS (CHECK THE SYSTEM IF 32 BITS OR 64 BITS)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (GOTO 64) ELSE (GOTO 32)
 
::CHECA SE EXISTE O EXECUTAVEL DO SPARK SE EXISTE VALIDA E INSTALAR A VERSAO CORRETA SE NAO EXISTE INSTALA
::CHECK THERE IS SPARK EXECUTABLE IF THERE IS VALID AND INSTALL THE CORRECT VERSION IF THERE IS NO INSTALL
:32
IF EXIST "%X32%" (GOTO VALID) ELSE ( GOTO INSTALL )
:64
IF EXIST "%X64%" (GOTO VALID64) ELSE ( GOTO INSTALL )
 
::(CHECA VERSAO DO SPARK 32 BITS)  CHECK THE CORRECT VERSION OF SPARK 32 BITS
::VERIFICA A VERSAO DO SPARK 32 BITS SE A VERSAO FOR DIFERENTE DA VARIAVEL %SPARK% INSTALA A VERSAO CORRETA
::CHECK THE CORRECT VERSION OF SPARK 32 BITS IF VERSION IS DIFFERENT FROM% SPARK% VAR INSTALL VERSION IF EQUAL EXIT BATCH
:VALID
for /f %%d in ('powershell -command "[System.Diagnostics.FileVersionInfo]::GetVersionInfo('%X32%').FileVersion"') do set SPARK_VER=%%d
IF "%SPARK_VER%" NEQ "%SPARK%" ( GOTO INSTALL ) ELSE (GOTO END)
::(CHECA VERSAO DO SPARK 64 BITS)  CHECK THE CORRECT VERSION OF SPARK 64 BITS
::VERIFICA A VERSAO DO SPARK 64 BITS SE A VERSAO FOR DIFERENTE DA VARIAVEL %SPARK% INSTALA A VERSAO CORRETA
::CHECK THE CORRECT VERSION OF SPARK 64 BITS IF VERSION IS DIFFERENT FROM% SPARK% VAR INSTALL VERSION IF EQUAL EXIT BATCH
:VALID64
for /f %%d in ('powershell -command "[System.Diagnostics.FileVersionInfo]::GetVersionInfo('%X64%').FileVersion"') do set SPARK_VER=%%d
IF "%SPARK_VER%" NEQ "%SPARK%" ( GOTO INSTALL ) ELSE (GOTO END)
 
:INSTALL
::CAMINHO DO INSTALADOR DO SPARK CASO QUEIRA INSTALAR O SPARK EM OUTRO DIRETORIO \\servidor\caminho de programas\spark_2_8_3.exe -q  -dir c:\outrocaminho
::CHANGE INSTALL PATH DIRECTORY spark_2_8_3.exe -q  -dir c:\FOLDER
::PARA DESINSTALAR O SPARK O COMANDO E C:\Program Files\Spark\uninstall.exe -Q OU C:\Program Files (x86)\Spark\uninstall.exe -Q
::UNINSTALL SPARK COMMAND OR C:\Program Files\Spark\uninstall.exe -Q OU C:\Program Files (x86)\Spark\uninstall.exe -Q
Echo INSTALANDO VERSAO PADRAO AGUARDE...
::ALTERE AQUI O CAMINHO DO INSTALADOR DO SPARK (CHANGE THE SPARK.EXE PATH PROGRAM HERE)
CLS
\\servidor\FOLDER\spark_2_8_3.exe -q
GOTO END
:END
CLS
EXIT