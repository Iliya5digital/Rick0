$Rules=(New-object –comObject HNetCfg.FwPolicy2).rules
$Rules | export-csv test.csv -Delimiter ',' -Nti 

::bloquear usb usuario local
REG ADD "HKCU\Software\Policies\Microsoft\Windows\RemovableStorageDevices" /v "Deny_All" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices" /v "Deny_All" /t REG_DWORD /d 1 /f > nul