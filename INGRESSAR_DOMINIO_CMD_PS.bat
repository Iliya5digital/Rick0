@echo off
SET "DOMINIO=dominio.com.br"
SET "ADMIND=admistrador"
set "PWADMIN=senha"
TITLE INGRESSANDO "%COMPUTERNAME%" NO "%DOMINIO%"
ECHO Ingressando %COMPUTERNAME%" NO "%DOMINIO%" Aguarde...
start /wait "%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" -c "$DomName = '$env:DOMINIO' ;$user = '$env:ADMIND'; $pass = ConvertTo-SecureString '$env:PWADMIN' -AsPlainText -Force ;$DomainCred = New-Object System.Management.Automation.PSCredential $DomName\$user,$pass; Add-Computer -Domainname $DomName -credential $DomainCred" 2>nul
EXIT