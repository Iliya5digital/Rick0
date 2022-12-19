#no arquivo maquinas coloque o nome das maquinas ou ip delas.
$ArrComputers = gc .\maquinas.txt
$OutputLog = ".\saida.txt" # Log Principal
#$NotRespondingLog = ".\semresposta.txt" # Log com maquinas sem resposta

$ErrorActionPreference = "Stop" # Or add '-EA Stop' to Get-WmiObject queries
Clear-Host

ForEach ($Computer in $ArrComputers) 
{
    try
    {
        $computerSystem = get-wmiobject Win32_ComputerSystem -Computer $Computer
        $computerBIOS = get-wmiobject Win32_BIOS -Computer $Computer
        $Version = Get-WmiObject -Namespace "Root\CIMv2" `
            -Query "Select * from Win32_ComputerSystemProduct" `
            -computer $computer | select -ExpandProperty version
        $MonitorInfo = gwmi WmiMonitorID -Namespace root\wmi `
            -computername $Computer `
            | Select PSComputerName, `
                @{n="Model";e={[System.Text.Encoding]::ASCII.GetString(`
                    $_.UserFriendlyName -ne 00)}},
                @{n="Serial Number";e={[System.Text.Encoding]::ASCII.GetString(`
                    $_.SerialNumberID -ne 00)}}     
    }
    catch
    {
        #$Computer | Out-File -FilePath $NotRespondingLog -Append -Encoding ASCII
		$Erro ="$Computer,-,-,-,-"
		$Erro| Out-File -FilePath $OutputLog -Append -Encoding ASCII
        continue
    }

    #$Header = "MAQ.{0}" -f $computerSystem.Name
    # Outputting and logging header.
    #$Computer  -BackgroundColor DarkCyan
    #$Header | Out-File -FilePath $OutputLog -Append -Encoding ASCII
    $Output = (@"
$Computer,{2},{0},{3},{4}
"@) -f $computerSystem.Model, $computerBIOS.SerialNumber, $Version, `
       $MonitorInfo.Model, $MonitorInfo."Serial Number"

    # Ouputting and logging WMI data
    Write-Host $Output
    $Output | Out-File -FilePath $OutputLog -Append -Encoding ASCII
}