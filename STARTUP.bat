@echo off
IF NOT EXIST "%userprofile%\Desktop\Atalhos_Home" MD "%userprofile%\Desktop\Atalhos_Home"
SET "APP_PASTA=%SYSTEMDRIVE%\Suporte\Apphome"
SET "APP_LNK=%userprofile%\Desktop\Apphomeoffice.lnK"
SET "LNK_PASTA=%SYSTEMDRIVE%\suporte\atalhos_home"
SET "ATALHOS_PXX=%userprofile%\Desktop\atalhos_home"
SET "A_LNK=%userprofile%\Desktop\Atalhos_Home.lnK"
SET "LOGIN_LNK=%userprofile%\Desktop\Login.lnK"
SET "LOGIN_BAT=%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\XXX.bat"
SET "LNK_TEAM=%userprofile%\Desktop\TeamViewerQS.lnk"
SET "TEAM_EXE=%SYSTEMDRIVE%\suporte\Apphome\TeamViewerQS.exe"

:REMOVE PASTA ATALHOS E DEIXA SO UM LINK
IF EXIST "%ATALHOS_PXX%" RD /S /Q "%ATALHOS_PXX%"
::PASTA HOME OFFICE ATALHO
IF NOT EXIST "%APP_LNK%" powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%APP_LNK%');$s.TargetPath='%APP_PASTA%';$s.Save()"
::ATALHOS TIM
IF NOT EXIST "%A_LNK%" powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%A_LNK%');$s.TargetPath='%LNK_PASTA%';$s.Save()"
::ATALHO AJUSTE DE AUDIO
IF NOT EXIST "%userprofile%\Desktop\Audio Tuning Wizard.lnk" powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%userprofile%\Desktop\Audio Tuning Wizard.lnk');$s.TargetPath='%PROGRAMFILES%\Cisco Systems\Cisco IP Communicator\AudioTuningWizard.exe';$s.Save()"
::ATALHO LOGIN DE REDE
IF NOT EXIST "%LOGIN_LNK%" powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%LOGIN_LNK%');$s.TargetPath='%LOGIN_BAT%';$s.Save()"
::ATALHO TEAM VIEWER
IF NOT EXIST "%LNK_TEAM%" powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%LNK_TEAM%');$s.TargetPath='%TEAM_EXE%';$s.Save()"