@echo off
setlocal EnableDelayedExpansion
TITLE COMPARA DOIS ARQUIVOS E RETORNA RESULTADO
ECHO LENDO 1.TXT COMPARANDO COM 2.TXT E SALVANDO EM RESULTADO.TXT AGUARDE...
pushd "%~dp0"
IF EXIST "%~dp0resultado.txt" del /f /q "%~dp0resultado.txt"
findstr /i /R /G:%~dp01.txt %~dp02.txt >>resultado.txt
popd
EXIT