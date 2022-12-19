New-Item -ItemType Directory -Force -Path $env:systemdrive\KB |out-null
$DestinationFolder ="$env:systemdrive\KB\"
$FilesUrlList = ( 
"http://download.windowsupdate.com/c/msdownload/update/software/uprl/2019/07/windows6.1-kb4507704-x86_f759e80f628a4b86c57a6ceceac7e8cdc3478881.msu","http://download.windowsupdate.com/c/msdownload/update/software/uprl/2019/07/windows6.1-kb4507704-x64_c79431bd517b2a6728fe1315893e250f00266be6.msu",   #Windows 7 (6.1)-6.1.7601
"http://download.windowsupdate.com/d/msdownload/update/software/uprl/2019/07/windows8.1-kb4507704-x64_f6ff983a9d2e8b9d770741e802bf3e5ffe67c0e5.msu","http://download.windowsupdate.com/d/msdownload/update/software/uprl/2019/07/windows8.1-kb4507704-x86_8c0d1d7a0dd4f6b4c0638c061535f8338fbb99df.msu",   #Windows 8.1 (6.3)-6.2.9200
"http://download.windowsupdate.com/c/msdownload/update/software/updt/2019/07/windows10.0-kb4505903-x64_af8c6ab868423055a750797b6d52c1bd67e15a95.msu","http://download.windowsupdate.com/c/msdownload/update/software/updt/2019/07/windows10.0-kb4505903-x86_52268cd36aed64fbd9ade223fb9256a0c60f3184.msu", #Windows 10 (1903)-10.0.18362
"http://download.windowsupdate.com/d/msdownload/update/software/updt/2019/07/windows10.0-kb4505658-x64_cb660f3191eba56217694635b48d50d36883c3f2.msu","http://download.windowsupdate.com/d/msdownload/update/software/updt/2019/07/windows10.0-kb4505658-x86_d3f8a7b02893e100695b96baf501ddc3127d05c5.msu", #Windows 10 (1809)-10.0.17763
"http://download.windowsupdate.com/d/msdownload/update/software/updt/2019/07/windows10.0-kb4507466-x86_e5313f726a95a494f332e4b5c52f8960a868b87b.msu","http://download.windowsupdate.com/d/msdownload/update/software/updt/2019/07/windows10.0-kb4507466-x64_610af01afaf7e730d6b6b010a1f4bf7dbcc21088.msu", #Windows 10 (1803)-10.0.17134
"http://download.windowsupdate.com/c/msdownload/update/software/updt/2019/07/windows10.0-kb4507465-x86_81992fb3fb03686fa22c934044f538f255aaec14.msu","http://download.windowsupdate.com/c/msdownload/update/software/updt/2019/07/windows10.0-kb4507465-x64_13c9fd41bed4115aa6aee97abd2ea40d245279c6.msu", #Windows 10 (1709)-10.0.16299
"http://download.windowsupdate.com/d/msdownload/update/software/updt/2019/07/windows10.0-kb4507467-x64_d49f6df8f0f14cb7cd6d66b602fb3754f25c0ac9.msu","http://download.windowsupdate.com/c/msdownload/update/software/updt/2019/07/windows10.0-kb4507467-x86_2111d5d4d2c8b9a74458b37e9adb5b2843936958.msu", #Windows 10 (1703)-10.0.15063
"http://download.windowsupdate.com/c/msdownload/update/software/updt/2019/07/windows10.0-kb4507459-x86_0686c650c2a6c6a4e9afed53127a483629d81ae3.msu","http://download.windowsupdate.com/c/msdownload/update/software/updt/2019/07/windows10.0-kb4507459-x64_67d347cdf1933c9da47f7e6f96424ce89debce41.msu"  #Windows 10 (1607)-10.0.14393
)                                                                                                                                                                                                                                                                                                        
function Download()
{
	Import-Module BitsTransfer
	Write-Host "Modulo deTransferencia de Plano de Fundo Carregado"
	Write-Host "Download das atualizacoes KB FIM DO HORARIO DE VERAO WINDOWS 10,8,8.1,7 SP1 (64 E 32 BITS)..."

	ForEach ($FileUrl in $FilesUrlList)
	{
		## Get the file name
		$DestinationFileName = $FileUrl.Split('/')[-1]
	
		Try
		{
			
			## Retorna true se o arquivo existe, caso esteja ausente retorna false
			If (!(Test-Path "$DestinationFolder\$DestinationFileName"))
			{
				Write-Host "`'$FileUrl`' ..."
				Start-BitsTransfer -Source $FileUrl -Destination $DestinationFolder\$DestinationFileName -Priority High -ErrorVariable err
				If ($err) {Throw ""}
			}
			Else
			{
				Write-Host "Arquivo $DestinationFileName ja existe, ignorando..."
			}
		}
		Catch
		{
			Write-Warning "Ocorreu um erro ao fazer o download `'$DestinationFileName`'"
			break
		}
	}
}
CLEAR-HOST
Download