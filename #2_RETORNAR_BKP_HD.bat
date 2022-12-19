@ECHO off
TITLE RESTAURANDO BACKUP DO HD EXTERNO...
::Elevando privilegio para executar o Robocopy
pushd "%~dp0" 
if not "%1"=="am_admin" (%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe start -verb runas '%0' am_admin & exit /b)  
::taskkill /f /fi "USERNAME eq %username%" /fi "IMAGENAME ne mstsc.exe" /fi "IMAGENAME ne explorer.exe" /fi "IMAGENAME ne %~nx0" /fi "IMAGENAME ne cmd.exe" /fi "IMAGENAME ne conhost.exe" /fi "IMAGENAME ne notepad.exe" /fi "IMAGENAME ne robocopy.exe" &CLS >nul 
:USUARIO
SETLOCAL
SET "ID="
TITLE SELECIONE A PASTA PARA RESTAURAR O BACKUP
CLS
:: Interacao do USUARIO para selecionar a pasta de backup
set "psCommand="(new-object -COM 'Shell.Application')^.BrowseForFolder(0,'SELECIONE A PASTA:','^&H200','%~d0\BACKUP\OK').Self.Path""
for /f "usebackq delims=" %%I in (`%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe %psCommand%`) do set "ID=%%I"
CLS
:: Salva o nome da pasta na variavel IDS a variavel ID e o caminho completo da pasta
for %%d in ("%ID%") do set "IDS=%%~nxd"
:: Checa Se o valor informado e nulo caso seja solicita novamente
IF DEFINED ID (goto CONTINUE) else (goto USUARIO)
:CONTINUE
TITLE Retornando Backup de ["%IDS%"]
:: Checa Se existe a pasta caso nao exista questiona se que salvar o backup em outro local
IF NOT EXIST "%SYSTEMDRIVE%\Users\%IDS%" CHOICE /c SN /T 10 /D S /m "Nao existe "%SYSTEMDRIVE%\Users\%IDS%" deseja Salvar BACKUP na pasta "%SYSTEMDRIVE%\BACKUP\OK\%IDS%"?"
TITLE Restaurando Backup de ["%IDS%"]
IF %ERRORLEVEL% EQU 1 (CLS & goto BACKUPPST)
IF %ERRORLEVEL% EQU 2 (ECHO Nao foi Possivel Concluir o Backup... & ECHO.& TIMEOUT 7 & EXIT)
 
IF EXIST "%SYSTEMDRIVE%\Users\%IDS%" CHOICE /c SN /T 10 /D S /m "Deseja Restaurar o Backup na pasta "%SYSTEMDRIVE%\Users\%IDS%"?"
TITLE Restaurando Backup de ["%IDS%"]
IF %ERRORLEVEL% EQU 1 (CLS & goto BACKUP)
IF %ERRORLEVEL% EQU 2 (ECHO Nao foi Possivel Concluir o Backup... & ECHO.& TIMEOUT 7 & EXIT)
 
:BACKUP
CLS
ECHO Backup Sendo Restaurado Aguarde...
SET "LOCAL=%SYSTEMDRIVE%\Users\%IDS%"
SET "LOGBKP=%~d0\BACKUP\OK\OK.log"
TITLE Fazendo Backup de ["%ID%"] para ["%LOCAL%"]
robocopy "%ID%" "%LOCAL%" /E /ZB /DCOPY:T /FFT /DST /XA:SH /R:1 /W:1 /NP /TEE /FP /NJH /XX /LOG+:"%LOGBKP%"
CLS
GOTO STICK

:BACKUPPST
SET "LOCAL=%SYSTEMDRIVE%\BACKUP\OK\%IDS%"
SET "LOGBKP=%~d0\backup\OK\OK.log"
robocopy "%ID%" "%LOCAL%" /E /ZB /DCOPY:T /FFT /DST /XA:SH /XJD /XJF /R:1 /W:1 /NP /TEE /FP /NJH /XX /LOG+:"%LOGBKP%"
GOTO STICK
:STICK
IF EXIST "%ID%\AppData\Roaming\Microsoft\Sticky Notes\*.snt" ECHO f| xcopy /R /S /H /D /V /Y /I /O /F "%ID%\AppData\Roaming\Microsoft\Sticky Notes\*.snt" "%LOCAL%\AppData\Roaming\Microsoft\Sticky Notes\*.snt"> nul
IF EXIST "%ID%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\*.*" ECHO f| xcopy /R /O /E /H /D /V /Y /I "%ID%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\*.*" "%LOCAL%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\*.*"> nul
CLS
GOTO ESCOLHA
:ESCOLHA
CHOICE /c SN /T 10 /D N /m "Deseja Restaurar Outro Backup?"
IF %ERRORLEVEL% EQU 1 (CLS & GOTO USUARIO)
IF %ERRORLEVEL% EQU 2 (ECHO. & ECHO Backup Restaurado... & ECHO. &ECHO #Backup "%LOCAL%" &ECHO #Log %~d0\backup\OK.log & TIMEOUT 3 & goto END)
:END
explorer "%LOCAL%" & ENDLOCAL & EXIT