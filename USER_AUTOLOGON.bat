@ECHO OFF
SET "USER=USUARIO"
SET "PASS=PASSWORD"
net user %USER% %PASS% /FULLNAME:"Descricao do usuario" /PASSWORDCHG:no /add >NUL
wmic useraccount WHERE Name='%USER%' set PasswordExpires=false >NUL
net localgroup Administrators %USER% /add >NUL
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d "1" /f >NUL
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d "%USER%" /f >NUL
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d "%PASS%" /f >NUL
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DisableCAD /t REG_DWORD /d "1"/f >NUL
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d %computername% /f >nul
EXIT