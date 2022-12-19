IF NOT EXIST "%~dp0%WIFI" MD "%~dp0WIFI"
netsh wlan export profile folder="WIFI\." key=clear
@echo off