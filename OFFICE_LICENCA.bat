@ECHO OFF
setlocal EnableDelayedExpansion
pushd "%~dp0"
SET "X86=%PROGRAMFILES%\Microsoft Office\Office16\ospp.vbs"
SET "X64=%PROGRAMFILES(x86)%\Microsoft Office\Office16\ospp.vbs"
if not "%1"=="am_admin" ("%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" start -verb runas '%0' am_admin & exit /b)
popd
TITLE ATIVANDO OFFICE 2019 Aguarde...
ECHO ATIVANDO OFFICE 2019 Aguarde...
::ENCERRANDO PROCESSOS
SET "KILL=EXCEL.EXE,POWERPNT.EXE,WINWORD.EXE"
for %%i in (%KILL%) do (
tasklist | find /i "%%i" && taskkill /im "%%i" /F 2>nul &CLS)

IF EXIST "%X86%" (GOTO 32BITS)
IF EXIST "%X64%" (GOTO 64BITS)

:32BITS

TITLE ATIVANDO Office19ProPlus2019 32 bits
ECHO ATIVANDO Office19ProPlus2019 32 bits Aguarde...
FOR %%d in ("%X86%") do SET "APPDIR32=%%~dpd"
cd "%APPDIR32%" & SET "cmd=cscript ospp.vbs"
%cmd% /dstatus | findstr /i "Office19ProPlus2019VL"
if not "%errorlevel%" EQU 0 (for /f %%x in ('dir /b ..\root\Licenses16\ProPlus2019VL*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x")
%cmd% /setprt:1688 >nul & %cmd% /unpkey:6MWKP >nul & %cmd% /inpkey:NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP >NUL & %cmd% /sethst:s8.uk.to & %cmd% /act & %cmd% /dstatus 
echo.
::2. ProjectPro
TITLE ATIVANDO OFFICE ProjectPro 2019 32 bits Aguarde...
ECHO ATIVANDO OFFICE ProjectPro2019 32 bits Aguarde...
%cmd% /dstatus | findstr "Office19ProjectPro2019VL"
if not "%errorlevel%" EQU 0 (for /f %%x in ('dir /b ..\root\Licenses16\ProjectPro2019VL*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x") 
%cmd% /setprt:1688 >nul & %cmd% /setprt:1688 >nul & %cmd% /unpkey:PKD2B >nul & %cmd% /inpkey:NB4NPR-3FKK7-T2MBV-FRQ4W-PKD2B >NUL & %cmd% /sethst:s8.uk.to & %cmd% /act & %cmd% /dstatus 
GOTO END

:64BITS
::1. ProPlus
TITLE ATIVANDO Office19ProPlus2019 64 bits Aguarde...
ECHO ATIVANDO Office19ProPlus2019 Aguarde...
FOR %%d in ("%X64%") do SET "APPDIR64=%%~dpd"
cd "%APPDIR64%" & SET "cmd=cscript ospp.vbs"
%cmd% /dstatus | findstr /i "Office19ProPlus2019VL"
if not "%errorlevel%" EQU 0 (for /f %%x in ('dir /b ..\root\Licenses16\ProPlus2019VL*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x") 
%cmd% /setprt:1688 >nul & %cmd% /unpkey:6MWKP >nul & %cmd% /inpkey:NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP >NUL & %cmd% /sethst:s8.uk.to & %cmd% /act & %cmd% /dstatus 
echo.
::2. ProjectPro
TITLE ATIVANDO OFFICE ProjectPro 2019 64 bits
ECHO ATIVANDO OFFICE ProjectPro2019 AGUARDE...
cd "%APPDIR64%" & SET "cmd=cscript ospp.vbs"
%cmd% /dstatus | findstr /i "Office19ProjectPro2019VL"
if not "%errorlevel%" EQU 0 (for /f %%x in ('dir /b ..\root\Licenses16\ProjectPro2019VL*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x") 
%cmd% /setprt:1688 >nul & %cmd% /unpkey:PKD2B >nul & %cmd% /inpkey:NB4NPR-3FKK7-T2MBV-FRQ4W-PKD2B >NUL & %cmd% /sethst:s8.uk.to & %cmd% /act & %cmd% /dstatus 
GOTO END

:END
EXIT