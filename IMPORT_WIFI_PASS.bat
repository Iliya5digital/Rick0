CD "%~dp0WIFI"
for %%I in (*.xml) do netsh wlan add profile filename="%%~nxI"
@echo off
pause