@ECHO off
TITLE SCRIPT BACKUP HD EXTERNO..
::Elevando privilegio para executar o Robocopy
setlocal EnableDelayedExpansion
pushd "%~dp0"
SET "PSW=%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe"
if not "%1"=="am_admin" (%PSW% start -verb runas '%0' am_admin & exit /b)  
::taskkill /f /fi "USERNAME eq %username%" /fi "IMAGENAME ne mstsc.exe" /fi "IMAGENAME ne explorer.exe" /fi "IMAGENAME ne %~nx0" /fi "IMAGENAME ne cmd.exe" /fi "IMAGENAME ne conhost.exe" /fi "IMAGENAME ne notepad.exe" /fi "IMAGENAME ne robocopy.exe" &CLS >nul 
:USUARIO
SETLOCAL
SET "ID="
TITLE SELECIONE A PASTA PARA REALIZAR O BACKUP
CLS
:: Interacao do USUARIO para selecionar a pasta de backup
set "psCommand="(new-object -COM 'Shell.Application')^.BrowseForFolder(0,'SELECIONE A PASTA:','^&H200','').Self.Path""
for /f "usebackq delims=" %%I in (`%PSW% %psCommand%`) do set "ID=%%I"
:: Checa Se o valor informado e nulo caso seja solicita novamente que seja informado caso nao prossegue
::IF DEFINED ID (GOTO CONTINUE) else (GOTO USUARIO)
IF NOT EXIST "%ID%" (GOTO USUARIO) ELSE (GOTO CONTINUE)

:CONTINUE
for /f %%d in ('%PSW% -c "$env:ID.length"') do SET "LEN=%%d"
IF %LEN% LEQ 3 (SET "IDS=%ID::\=%" & SET "ORIGEM=%ID:\=%" ) ELSE (for %%d in ("%ID%") do set "IDS=%%~nxd" SET & SET "ORIGEM=%ID%")
TITLE Fazendo Backup de ["%ID%"]
IF "%NEO%"=="1" (GOTO BACKUP)
:: Questiona o USUARIO se ele quer apagar bkps antigos ou nao e valida somente com S/N
for /F %%i in ('dir "%~d0\BACKUP\OK\*" /O-D /B /A:D') do set CHK=%%i
IF NOT DEFINED %CHK% choice /c SN /T 10 /D N /m "Deseja Deletar bkps antigos da pasta %~d0\BACKUP\OK do hd externo?"
IF %ERRORLEVEL% EQU 1 (forfiles /P "%~d0\BACKUP\OK" /M * /C "cmd /c if @isdir==TRUE rmdir /S /Q @file" & GOTO BACKUP)
IF %ERRORLEVEL% EQU 2 (IF NOT EXIST "%~d0\BACKUP\OK\" md "%~d0\BACKUP\OK\" & GOTO BACKUP)

:BACKUP
IF NOT EXIST "%~d0\BACKUP\OK\" md "%~d0\BACKUP\OK\" 
SET "DESTINO=%~d0\BACKUP\OK\%IDS%"
SET "LOGBKP=%~d0\backup\OK\copia.log"
TITLE Fazendo Backup de ["%ORIGEM%"] para ["%DESTINO%"]
ECHO Backup Sendo Efetuado para "%DESTINO%" Aguarde...
Robocopy "%ORIGEM%" "%DESTINO%" /S /ZB /DCOPY:T /FFT /DST /XA:SH /XJD /XJF /R:3 /XF "*.tmp" /XD "All Users" "DefaultAppPool" "Public" "administrator" "default" "Links" "WFMData" ".swt" "AppData" "Contacts" "Searches" /NP /TEE /FP /NJH /XX /LOG+:"%LOGBKP%"
IF EXIST "%ID%\AppData\Roaming\Microsoft\Sticky Notes\*.snt" ECHO f|xcopy /R /S /H /D /V /Y /O /F "%ID%\AppData\Roaming\Microsoft\Sticky Notes\*.snt" "%~d0\BACKUP\OK\%IDS%\AppData\Roaming\Microsoft\Sticky Notes\*.snt"> nul
IF EXIST "%ID%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\plum.sqlite" ECHO f|xcopy /R /S /H /D /V /Y /O /F "%ID%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\*.*" "%~d0\BACKUP\OK\%IDS%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\*.*"> nul
IF EXIST "%~d0\BACKUP\OK\%IDS%\AppData\" attrib +h +s "%~d0\BACKUP\OK\%IDS%\AppData" /S /D> nul
CLS
GOTO ESCOLHA

:ESCOLHA
choice /c SN /T 10 /D N /m "Deseja Realizar um novo Backup?"
IF %ERRORLEVEL% EQU 1 (CLS & SET "NEO=1" & GOTO USUARIO)
IF %ERRORLEVEL% EQU 2 (ECHO. & ECHO Backup Concluido... & ECHO. &ECHO #Backup %DESTINO% &ECHO #Log %LOGBKP% & TIMEOUT 3 & GOTO END)
:END
explorer "%~d0\BACKUP\OK\" & ENDLOCAL & POPD & EXIT