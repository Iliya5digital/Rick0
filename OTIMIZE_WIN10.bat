@echo off
TITLE BAT OTIMIZACAO DO WINDOWS 10 By Rick(TESTADO NA VERSAO 21h2)
echo Checando Permissoes...
pushd "%~dp0"
if not "%1"=="am_admin" ("%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe" start -verb runas '%0' am_admin & exit /b)
setlocal EnableDelayedExpansion
CLS
ver | find "10." > nul
if errorlevel 1 (
	echo Sua versão do Windows nao e o Windows 10... Ainda. Prepare-se, o Windows 10 esta chegando^^!
	TIMEOUT 5
	exit
)
cls
echo Torne o Windows 10 Otimo novamente^^! Batch Otimizador do Windows 10.
pause
::---------------
echo | set /p= Desativando Serviços de Telemetria...
echo.
::DESABILITANDO SERVICOS
set unsafe_services=^
    WMPNetworkSvc,OfficeSvc,DusmSvc,Themes,DiagTrack
for %%i in (%unsafe_services%) do (
echo Servico desativado: %%i [42m[OK][0m
SC stop %%i >nul
SC config %%i start= disabled >nul
)

echo | set /p= Habilitando Serviços Necessarios...
::HABILITANDO SERVICOS
echo.
set enable_services=^
    AeLookupSvc,PcaSvc,^
    ALG,SysMain
for %%e in (%enable_services%) do (
echo Servico ativado: %%e [42m[OK][0m
SC config %%e start= demand >nul
SC start %%e >nul
)

echo Adicionando ajustes de registro ...
echo.
echo | set /p=Desativar Compartilhamentos Administrativos
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m
echo | set /p=Desativando Apps em Segundo Plano
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f
echo  [42m[OK][0m
echo | set /p=Visualizacao de botoes de tarefas 
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarGlomLevel /t REG_DWORD /d "2" >NUL
echo  [42m[OK][0m

echo | set /p=Remover One drive inicializacao
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /F > nul
echo  [42m[OK][0m
echo | set /p=Desativando telemetria...
::Desativando o Telemetria do Windows
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v ShowedToastAtLevel /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\SOFTWARE\Microsoft\Policies\Microsoft\Windows\DataColletion" /v AllowTelemetry /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\DeviceDeleteRequest" /v LastRequestTime /t REG_QWORD /d 8 /f > nul
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v SystemSettingsDownloadMode /t REG_DWORD /d 3 /f
echo  [42m[OK][0m


::================================================Cortana e Pesquisa na Web=========================================================::
echo | set /p=Desativar a pesquisa da Cortana e da Web
REG ADD "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f > nul
::================================================Fim Desativar Cortana e Pesquisa na Web=========================================================::
echo  [42m[OK][0m

echo | set /p=Desativar otimizacao de entrega(download de atualizacoes para outras maquinas usando a sua banda)
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar Sensor de Wi-Fi
REG ADD "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d 0 /f > nul
::Desativando Hotpost 2.0 nas configurações do Wifi
REG ADD "HKLM\SOFTWARE\Microsoft\WlanSvc\AnqpCache" /v OsuRegistrationStatus /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

::----------------------------------------------------------------------------------------------------------------------------::
::echo | set /p=Desativar Histórico de Arquivos
::REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /v "Disabled" /t REG_DWORD /d 1 /f > nul
::echo  [42m[OK][0m

echo | set /p=Desativar dicas do Windows 
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar Ajuda Ativa
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar o feedback do Windows
REG ADD "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar o feedback da Ajuda da Microsoft 
REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar Feedback de Escrita 
REG ADD "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar a Camera da Tela de Bloqueio
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar a telemetria do Office 2016 e 2015
REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "Enablelogging" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "EnableUpload" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\osm" /v "Enablelogging" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\osm" /v "EnableUpload" /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

::echo | set /p=Desativar Blocos dinamicos
::REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoTileApplicationNotification" /t REG_DWORD /d 1 /f > nul
::echo  [42m[OK][0m

::echo | set /p=Desativar AutoPlay e AutoRun
::REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f > nul
::REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoAutorun" /t REG_DWORD /d 1 /f > nul
::echo  [42m[OK][0m

echo | set /p=Nao envie estatisticas do Windows Media Player
REG ADD "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

echo | set /p=Definir o Visualizador de foto padrao(Win 7)
REG ADD "HKCU\SOFTWARE\Classes\.ico" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKCU\SOFTWARE\Classes\.tiff" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKCU\SOFTWARE\Classes\.bmp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKCU\SOFTWARE\Classes\.png" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKCU\SOFTWARE\Classes\.gif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKCU\SOFTWARE\Classes\.jpeg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKCU\SOFTWARE\Classes\.jpg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
echo  [42m[OK][0m

::echo | set /p=Desativar o alerta "Voce tem novos aplicativos que podem abrir esse tipo de arquivo"
::REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d 1 /f > nul
::echo  [42m[OK][0m

echo | set /p=Abrir o Meu Computador ao inves do acesso rapido
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

::echo | set /p=Nao mostrar arquivos usados recentemente no Acesso rapido
::REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f > nul
::echo  [42m[OK][0m

::echo | set /p=Nao mostrar pastas usadas com freqüência no Acesso rapido 
::REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f > nul
::echo  [42m[OK][0m


::echo | set /p=Encerrar Programas que nao respondem automaticamente
::REG ADD "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f > nul
::echo  [42m[OK][0m

::echo | set /p=Maximize a qualidade do papel de parede
::REG ADD "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d 100 /f > nul
::echo  [42m[OK][0m


::echo | set /p=Adicionar Lixeira ao Painel de Navegacao
REG ADD "HKCU\SOFTWARE\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f > nul
REG ADD "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > nul
::echo  [42m[OK][0m

::echo | set /p=Este Computador
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d "0" /f > nul
::echo | set /p=Documentos do Usuario
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d "0" /f > nul
::echo  [42m[OK][0m

echo | set /p=Remover icone one driver do explorer
REG ADD "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

echo | set /p=Restaurar o menu de contexto classico no Explorer
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

::echo | set /p=Defina a caixa de selecao "Fazer isso para todos os itens atuais" por padrao na caixa de dialogo de conflito de operacao de arquivo 
::REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "ConfirmationCheckBoxDoForAll" /t REG_DWORD /d 1 /f > nul
::echo  [42m[OK][0m

echo | set /p=Ativar caminhos longos de NTFS
REG ADD "HKLM\SYSTEM\CurrentControlSet\Policies" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar Id De Anuncio ...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Ocultar botao visao de tarefas ...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

echo | set /p=Ocultar botao noticias e interesses da barra ...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar Mostrar Conteudo Sugerido e apps pre instalados
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /T REG_DWORD /d 0 /f > nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /T REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar Botao indicador de entrada ...
REG ADD "HKCU\Software\Microsoft\CTF\LangBar" /v ShowStatus /t REG_DWORD /d 3 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar o acesso de site a lista de idiomas no Windows 10
REG ADD "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Explorer Botoes pequenos, e outras otimizacoes..
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f > nul
::REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSmallIcons" /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f > nul
echo  [42m[OK][0m


echo | set /p=Desativar historico de digitacao e pesquisa
REG ADD "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f > nul
echo  [42m[OK][0m

echo | set /p=Desativar localizacao windows 10
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f > nul
echo  [42m[OK][0m

echo | set /p=Melhora Perfomance explorer
echo | set /p=Configurando Explorer ...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /V FullPath /T REG_DWORD /d 1 /F > nul
::REG ADD "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 1 /f > nul
::REG ADD "HKCU\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 1 /f > nul
::REG ADD "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f > nul
::REG ADD "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f > nul
::REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ServerAdminUI /t REG_DWORD /d 1 /f > nul
::MOSTRA EXTENSOES DE ARQUIVOS(HIDEFILEEXT=0 MOSTRA AS EXTENSOES,1 OCULTA AS EXTENSOES DE ARQUIVOS)
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f > nul
::MOSTRAR ARQUIVOS OCULTOS(HIDDEN),DE SISTEMA(ShowSuperHidden)
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f > nul
::REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 0 /f > nul
::FIM MOSTRAR ARQUIVOS OCULTO
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DontPrettyPath /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowInfoTip /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideIcons /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v MapNetDrvBtn /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTypeOverlay /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowStatusBar /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v StoreAppsOnTaskbar /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 1 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 1 /f > nul
::REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f > nul
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v  PeopleBand /t REG_DWORD /d 0 /f > nul
::REG ADD "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f > nul
echo  [42m[OK][0m

::echo | set /p=Tema Dark No Windows 10 e Ativar transparencia
::REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f > nul
::REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f > nul
::echo  [42m[OK][0m

echo | set /p=Configuracao Padrao de Usuarios
::----------------------------------------------------------------------------------------------------------------------------::
echo.
reg load HKLM\DEFAULT %SYSTEMDRIVE%\users\default\ntuser.dat > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d "0" /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d "0" /f > nul
::REG ADD "HKLM\DEFAULT\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f > nul
::REG ADD "HKLM\DEFAULT\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d 1 /f > nul
::REG ADD "HKLM\DEFAULT\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d 2 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f
::REG ADD "HKLM\DEFAULT\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Classes\.bmp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Classes\.gif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Classes\.ico" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Classes\.jpeg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Classes\.jpg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Classes\.png" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Classes\.tiff" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Policies\Microsoft\Windows\DataColletion" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d Deny /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /T REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /T REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\DeviceDeleteRequest" /v "LastRequestTime" /t REG_QWORD /d 8 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /T REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f > nul
::REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f > nul
::REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Microsoft\WlanSvc\AnqpCache" /v "OsuRegistrationStatus" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "EnableUpload" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "Enablelogging" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f > nul
::REG ADD "HKLM\DEFAULT\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\SYSTEM\CurrentControlSet\Policies" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 3 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 3 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DontPrettyPath" /t REG_DWORD /d 0 /f > nul
::EXTENSOES DE ARQUIVOS(HIDEFILEEXT=0 MOSTRA AS EXTENSOES,1 OCULTA AS EXTENSOES DE ARQUIVOS)
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f > nul
::REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 0 /f > nul
::FIM ARQUIVOS OCULTO E DE SISTEMA
::MOSTRAR EXTENSOES DE ARQUIVOS(HIDEFILEEXT=0 MOSTRA AS EXTENSOES,1 OCULTA AS EXTENSOES DE ARQUIVOS)
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 1 /f > nul
::FIM MOSTRAR EXTENSOES DE ARQUIVOS
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideIcons" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MapNetDrvBtn" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ServerAdminUI" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowStatusBar" /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTypeOverlay" /t REG_DWORD /d 1 /f > nul
::REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "StoreAppsOnTaskbar" /t REG_DWORD /d 1 /f > nul
::REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d "2" /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v  "PeopleBand" /t REG_DWORD /d 0 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d 0 /f > nul
::REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d 1 /f 
::REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 1 /f > nul
REG ADD "HKLM\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f > nul
reg delete "HKLM\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload HKLM\DEFAULT > nul
echo  [42m[OK][0m
::----------------------------------------------------------------------------------------------------------------------------::
::echo | set /p=Desativando Tarefas agendadas do Chrome E Office
::echo.
::taskkill /f /im chrome.exe /t > nul
::taskkill /f /im googleupdate.exe /t > nul
::for /f "tokens=2 delims=\" %%x in ('schtasks /query /fo:list ^| findstr ^^GoogleUpdateTask') do SCHTASKS /end /tn %%x > nul
::for /f "tokens=2 delims=\" %%x in ('schtasks /query /fo:list ^| findstr ^^GoogleUpdateTask') do SCHTASKS /change /tn %%x /disable > nul
::echo  [42m[OK][0m
echo Desativando Tarefas nao utilizadas
echo.
set spy_tasks=^
	"Microsoft\Office\Office Automatic Updates"^
	"Microsoft\Office\OfficeTelemetryAgentFallBack"^
	"Microsoft\Office\OfficeTelemetryAgentLogOn"^
	"Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
for %%i in (%spy_tasks%) do ((
		echo | set /p=%%i
		schtasks /end /tn %%i > nul
		schtasks /Change /TN %%i /disable > nul
		set item=%%i
		set dir_path="%tasks_dir%\!item:~1!
		set spy_task_deleted=1
		echo  [42m[OK][0m
	)
)
echo | set /p=Removendo Programas Nao utilizados
echo.
powershell.exe -command "Get-AppxPackage -AllUsers | ? {$_.name -notlike '*microsoft.windowscommunicationsapps*'} | ? {$_.name -notlike '1527c705-839a-4832-9118-54d4Bd6a0c89'} | ? {$_.name -notlike 'E2A4F912-2574-4A75-9BB0-0D023378592B'} | ? {$_.name -notlike 'F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE'} | ? {$_.name -notlike '*InputApp*'} | ? {$_.name -notlike '*Microsoft.AAD.BrokerPlugin*'} | ? {$_.name -notlike '*Microsoft.AccountsControl*'} | ? {$_.name -notlike '*Microsoft.AsyncTextService*'} | ? {$_.name -notlike '*Microsoft.BingWeather*'} | ? {$_.name -notlike '*Microsoft.BioEnrollment*'} | ? {$_.name -notlike '*Microsoft.CredDialogHost*'} | ? {$_.name -notlike '*Microsoft.DesktopAppInstaller*'} | ? {$_.name -notlike '*Microsoft.ECApp*'} | ? {$_.name -notlike '*Microsoft.HEIFImageExtension*'} | ? {$_.name -notlike '*Microsoft.LockApp*'} | ? {$_.name -notlike '*Microsoft.MSPaint*'} | ? {$_.name -notlike '*Microsoft.Messaging*'} | ? {$_.name -notlike '*Microsoft.Microsoft3DViewer*'} | ? {$_.name -notlike '*Microsoft.MicrosoftEdge*'} | ? {$_.name -notlike '*Microsoft.MicrosoftEdgeDevToolsClient*'} | ? {$_.name -notlike '*Microsoft.MicrosoftStickyNotes*'} | ? {$_.name -notlike '*Microsoft.NET.Native.Framework.1.6*'} | ? {$_.name -notlike '*Microsoft.NET.Native.Framework.1.7*'} | ? {$_.name -notlike '*Microsoft.NET.Native.Runtime.1.6*'} | ? {$_.name -notlike '*Microsoft.NET.Native.Runtime.1.7*'} | ? {$_.name -notlike '*Microsoft.Print3D*'} | ? {$_.name -notlike '*Microsoft.ScreenSketch*'} | ? {$_.name -notlike '*Microsoft.StorePurchaseApp*'} | ? {$_.name -notlike '*Microsoft.VCLibs.140.00*'} | ? {$_.name -notlike '*Microsoft.Wallet*'} | ? {$_.name -notlike '*Microsoft.WebMediaExtensions*'} | ? {$_.name -notlike '*Microsoft.WebpImageExtension*'} | ? {$_.name -notlike '*Microsoft.Win32WebViewHost*'} | ? {$_.name -notlike '*Microsoft.Windows.Apprep.ChxApp*'} | ? {$_.name -notlike '*Microsoft.Windows.AssignedAccessLockApp*'} | ? {$_.name -notlike '*Microsoft.Windows.CapturePicker*'} | ? {$_.name -notlike '*Microsoft.Windows.CloudExperienceHost*'} | ? {$_.name -notlike '*Microsoft.Windows.ContentDeliveryManager*'} | ? {$_.name -notlike '*Microsoft.Windows.Cortana*'} | ? {$_.name -notlike '*Microsoft.Windows.NarratorQuickStart*'} | ? {$_.name -notlike '*Microsoft.Windows.OOBENetworkCaptivePortal*'} | ? {$_.name -notlike '*Microsoft.Windows.OOBENetworkConnectionFlow*'} | ? {$_.name -notlike '*Microsoft.Windows.ParentalControls*'} | ? {$_.name -notlike '*Microsoft.Windows.PeopleExperienceHost*'} | ? {$_.name -notlike '*Microsoft.Windows.Photos*'} | ? {$_.name -notlike '*Microsoft.Windows.PinningConfirmationDialog*'} | ? {$_.name -notlike '*Microsoft.Windows.SecHealthUI*'} | ? {$_.name -notlike '*Microsoft.Windows.SecureAssessmentBrowser*'} | ? {$_.name -notlike '*Microsoft.Windows.ShellExperienceHost*'} | ? {$_.name -notlike '*Microsoft.Windows.XGpuEjectDialog*'} | ? {$_.name -notlike '*Microsoft.WindowsCalculator*'} | ? {$_.name -notlike '*Microsoft.WindowsCamera*'} | ? {$_.name -notlike '*Microsoft.WindowsPhone*'} | ? {$_.name -notlike '*Microsoft.WindowsSoundRecorder*'} | ? {$_.name -notlike '*Microsoft.WindowsStore*'} | ? {$_.name -notlike '*Microsoft.Xbox.TCUI*'} | ? {$_.name -notlike '*Microsoft.XboxApp*'} | ? {$_.name -notlike '*Microsoft.XboxGameCallableUI*'} | ? {$_.name -notlike '*Microsoft.XboxGameOverlay*'} | ? {$_.name -notlike '*Microsoft.XboxGamingOverlay*'} | ? {$_.name -notlike '*Microsoft.XboxIdentityProvider*'} | ? {$_.name -notlike '*Microsoft.XboxSpeechToTextOverlay*'} | ? {$_.name -notlike '*Microsoft.YourPhone*'} | ? {$_.name -notlike '*Windows.CBSPreview*'} | ? {$_.name -notlike '*Windows.PrintDialog*'} | ? {$_.name -notlike '*c5e2524a-ea46-4f67-841f-6a9465d9d515*'} | ? {$_.name -notlike '*windows.immersivecontrolpanel*'} | Remove-AppxPackage" >nul
echo  [42m[OK][0m

echo | set /p=Removendo Programas Aprovisionamento Online
echo.
powershell.exe -command "Get-AppxProvisionedPackage -online | ? {$_.packagename -notlike '*microsoft.windowscommunicationsapps*'} | ? {$_.packagename -notlike '1527c705-839a-4832-9118-54d4Bd6a0c89'} | ? {$_.packagename -notlike 'E2A4F912-2574-4A75-9BB0-0D023378592B'} | ? {$_.packagename -notlike 'F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE'} | ? {$_.packagename -notlike '*InputApp*'} | ? {$_.packagename -notlike '*Microsoft.AAD.BrokerPlugin*'} | ? {$_.packagename -notlike '*Microsoft.AccountsControl*'} | ? {$_.packagename -notlike '*Microsoft.AsyncTextService*'} | ? {$_.packagename -notlike '*Microsoft.BingWeather*'} | ? {$_.packagename -notlike '*Microsoft.BioEnrollment*'} | ? {$_.packagename -notlike '*Microsoft.CredDialogHost*'} | ? {$_.packagename -notlike '*Microsoft.DesktopAppInstaller*'} | ? {$_.packagename -notlike '*Microsoft.ECApp*'} | ? {$_.packagename -notlike '*Microsoft.HEIFImageExtension*'} | ? {$_.packagename -notlike '*Microsoft.LockApp*'} | ? {$_.packagename -notlike '*Microsoft.MSPaint*'} | ? {$_.packagename -notlike '*Microsoft.Messaging*'} | ? {$_.packagename -notlike '*Microsoft.Microsoft3DViewer*'} | ? {$_.packagename -notlike '*Microsoft.MicrosoftEdge*'} | ? {$_.packagename -notlike '*Microsoft.MicrosoftEdgeDevToolsClient*'} | ? {$_.packagename -notlike '*Microsoft.MicrosoftStickyNotes*'} | ? {$_.packagename -notlike '*Microsoft.NET.Native.Framework.1.6*'} | ? {$_.packagename -notlike '*Microsoft.NET.Native.Framework.1.7*'} | ? {$_.packagename -notlike '*Microsoft.NET.Native.Runtime.1.6*'} | ? {$_.packagename -notlike '*Microsoft.NET.Native.Runtime.1.7*'} | ? {$_.packagename -notlike '*Microsoft.Print3D*'} | ? {$_.packagename -notlike '*Microsoft.ScreenSketch*'} | ? {$_.packagename -notlike '*Microsoft.StorePurchaseApp*'} | ? {$_.packagename -notlike '*Microsoft.VCLibs.140.00*'} | ? {$_.packagename -notlike '*Microsoft.Wallet*'} | ? {$_.packagename -notlike '*Microsoft.WebMediaExtensions*'} | ? {$_.packagename -notlike '*Microsoft.WebpImageExtension*'} | ? {$_.packagename -notlike '*Microsoft.Win32WebViewHost*'} | ? {$_.packagename -notlike '*Microsoft.Windows.Apprep.ChxApp*'} | ? {$_.packagename -notlike '*Microsoft.Windows.AssignedAccessLockApp*'} | ? {$_.packagename -notlike '*Microsoft.Windows.CapturePicker*'} | ? {$_.packagename -notlike '*Microsoft.Windows.CloudExperienceHost*'} | ? {$_.packagename -notlike '*Microsoft.Windows.ContentDeliveryManager*'} | ? {$_.packagename -notlike '*Microsoft.Windows.Cortana*'} | ? {$_.packagename -notlike '*Microsoft.Windows.NarratorQuickStart*'} | ? {$_.packagename -notlike '*Microsoft.Windows.OOBENetworkCaptivePortal*'} | ? {$_.packagename -notlike '*Microsoft.Windows.OOBENetworkConnectionFlow*'} | ? {$_.packagename -notlike '*Microsoft.Windows.ParentalControls*'} | ? {$_.packagename -notlike '*Microsoft.Windows.PeopleExperienceHost*'} | ? {$_.packagename -notlike '*Microsoft.Windows.Photos*'} | ? {$_.packagename -notlike '*Microsoft.Windows.PinningConfirmationDialog*'} | ? {$_.packagename -notlike '*Microsoft.Windows.SecHealthUI*'} | ? {$_.packagename -notlike '*Microsoft.Windows.SecureAssessmentBrowser*'} | ? {$_.packagename -notlike '*Microsoft.Windows.ShellExperienceHost*'} | ? {$_.packagename -notlike '*Microsoft.Windows.XGpuEjectDialog*'} | ? {$_.packagename -notlike '*Microsoft.WindowsCalculator*'} | ? {$_.packagename -notlike '*Microsoft.WindowsCamera*'} | ? {$_.packagename -notlike '*Microsoft.WindowsPhone*'} | ? {$_.packagename -notlike '*Microsoft.WindowsSoundRecorder*'} | ? {$_.packagename -notlike '*Microsoft.WindowsStore*'} | ? {$_.packagename -notlike '*Microsoft.Xbox.TCUI*'} | ? {$_.packagename -notlike '*Microsoft.XboxApp*'} | ? {$_.packagename -notlike '*Microsoft.XboxGameCallableUI*'} | ? {$_.packagename -notlike '*Microsoft.XboxGameOverlay*'} | ? {$_.packagename -notlike '*Microsoft.XboxGamingOverlay*'} | ? {$_.packagename -notlike '*Microsoft.XboxIdentityProvider*'} | ? {$_.packagename -notlike '*Microsoft.XboxSpeechToTextOverlay*'} | ? {$_.packagename -notlike '*Microsoft.YourPhone*'} | ? {$_.packagename -notlike '*Windows.CBSPreview*'} | ? {$_.packagename -notlike '*Windows.PrintDialog*'} | ? {$_.packagename -notlike '*c5e2524a-ea46-4f67-841f-6a9465d9d515*'} | ? {$_.packagename -notlike '*windows.immersivecontrolpanel*'} | Remove-AppxProvisionedPackage -online" >nul
echo  [42m[OK][0m
setlocal
for /f %%d in ('powershell -command "[reflection.assembly]::LoadWithPartialName('System.Windows.Forms')|out-null;[windows.forms.messagebox]::Show('Deseja reiniciar o Computador?','Otimizador do Windows','YesNo')"') do set value=%%d
if /I "%value%"=="Yes" ( shutdown -r -t 0 -f ) ELSE ( exit )
ENDLOCAL
popd
EXIT