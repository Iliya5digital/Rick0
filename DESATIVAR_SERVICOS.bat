@echo off
Echo desabilitando SMB administrativo C$ D$
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f > nul
Echo DESABILITANDO SERVICOS INSEGUROS
::DESCRICAO
::"Serviço de Compartilhamento de Rede do Windows Media Player","WMPNetworkSvc"
::"Serviço do Servidor","Server"
::"Serviço de Compartilhamento de porta Net.TCP","NetTcpPortSharing"
::"Serviço de Registro Remoto","RemoteRegistry"
::"Serviço de Desativar servicos do Google "gupdatem","gupdate","GoogleChromeElevationService"
::"Descoberta SSDP","SSDPSRV"
set "unsafe_services=Server,RemoteRegistry,NetTcpPortSharing,WMPNetworkSvc,gupdatem,GoogleChromeElevationService,gusvc,gupdate,SSDPSRV"
for %%i in (%unsafe_services%) do (
echo Servico desativado: %%i [42m[OK][0m
SC stop %%i >nul
SC config %%i start= disabled >nul
)
EXIT