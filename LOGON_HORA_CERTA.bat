@echo off
::VERIFICANDO O HORARIO DE LOGON
::SET "CHECK=%time:~0,2%%time:~3,2%"
::CHECANDO SE A HORA E MINUTO E ABAIXO DAS 07:50 SE FOR ENCERRA OS PROCESSOS E FAZ LOGOFF SE NAO SAI DO SCRIPT
if %time:~0,2%%time:~3,2% LSS 750 (taskkill /f /fi "USERNAME eq %username%" /fi "IMAGENAME ne %~nx0" /fi "IMAGENAME ne cmd.exe" /fi "IMAGENAME ne conhost.exe" 2>nul & cls  & shutdown /l /f & EXIT ) ELSE (EXIT)
EXIT