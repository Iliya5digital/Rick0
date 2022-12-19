$Host.UI.RawUI.WindowTitle = "LOGS VPN EM TEMPO REAL"
$dateStr = Get-Date -Format "yyyy-MM-dd"
$flog = Get-Date -Format "yyyy/MM/dd"
$dir = $flog.replace('/','\')
#LOG VPN
$logFile = '\\servidor\log\-'+$dateStr+'.txt'
if (!(test-path -path $dir)) {new-item -path $dir -itemtype directory}
#LOG SENHA INCORRETA
$logpw = '.\'+$dir+'\SENHA-INCORRETA.txt'
#LOG CONTA BLOQUEADA
$loglocked = '.\'+$dir+'\CONTA-BLOQUEADA.txt'
#LOG USUARIO NAO ENCONTRADO
$svpn = '.\'+$dir+'\SEMVPN-CADASTRADA.txt'
#LOG USUARIO AGUARDANDO TOKEN
$utoken = '.\'+$dir+'\AGUARDANDO-TOKEN.txt'
#LOG USUARIO TOKEN INCORRETO
$utokenerr = '.\'+$dir+'\TOKEN-INVALIDO.txt'
Clear-Host
GC -Wait $logFile  | 
 % { 
		$Status = $_
	    if ($Status.Contains('status="Success"')) {Write-Host $Status -Foreground Green}#OK
		elseif ($Status.Contains('expecting email token')) {Write-Host $Status -Foreground Yellow 
		$Status -replace '\s\-Foreground Yellow', '' -match 'user="(.*?)"'
		$matches[1] | Out-File -FilePath $utoken -Append -Encoding UTF8} #AGUARDANDO TOKEN
        elseif ($Status.Contains('invalid password')) {Write-Host $Status -Foreground Red
		$Status -replace '\s\-Foreground Red', ''  -match 'user="(.*?)"'
		$matches[1] | Out-File -FilePath $logpw -Append -Encoding UTF8} #SENHA INCORRETA
		elseif ($Status.Contains('user locked')) {Write-Host $Status -Foreground Magenta
		$Status -replace '\s\-Foreground Magenta', '' -match 'user="(.*?)"'
		$matches[1] |  Out-File -FilePath $loglocked -Append -Encoding UTF8} #CONTA BLOQUEADA
	    elseif ($Status.Contains('user not found')) {Write-Host $Status -Foreground Cyan
		$Status -replace '\s\-Foreground Cyan', '' -match 'user="(.*?)"'
		$matches[1] | Out-File -FilePath $svpn -Append -Encoding UTF8} #SEM VPN
		elseif ($Status.Contains('invalid token')) {Write-Host $Status -Foreground DarkCyan
		$Status -replace '\s\-Foreground DarkCyan', '' -match 'user="(.*?)"'
		$matches[1] | Out-File -FilePath $utokenerr -Append -Encoding UTF8} #TOKEN INVALIDO
		else {Write-Host $Status} #SAIDA COMUM
 }