@echo off
ECHO CONFIGURANDO PERFIL PADRAO AGUARDE...
SC query "wuauserv" | FIND /i "STOPPED" >nul & IF ERRORLEVEL 1 SC stop "wuauserv" >nul & SC config "wuauserv" start= disabled >nul
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f >NUL
DEL /F /S /Q /A "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" >NUL
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarGlomLevel /t REG_DWORD /d "2" >NUL
::REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" /V "FFLAGS" /T REG_DWORD /D "1075839521" /F
::CRIANDO ATALHOS
::IF EXIST "%DESTINO%" powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%userprofile%\Desktop\TeamViewerQS.lnk');$s.TargetPath='%DESTINO%';$s.Save()"
::ENCERRANDO EXPLORER
tasklist | find /i "explorer.exe" && taskkill /im "explorer.exe" /F >nul &CLS & ECHO DESATIVANDO WINDOWS UPDATE & ECHO. &ECHO REMOVENDO ICONES DA BARRA DE TAREGA & ECHO. & ECHO NAO AGRUPAR JANELAS & ECHO. &ECHO ORGANIZAR ICONES AUTOMATICAMENTE
(goto) 2>nul & del "%~f0" > nul