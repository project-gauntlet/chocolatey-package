$ErrorActionPreference = 'Stop'

$releaseData = Invoke-RestMethod -Uri "https://api.github.com/repos/project-gauntlet/gauntlet/releases/latest"

$tagName = $releaseData.tag_name

$downloadUrl = $releaseData.assets | Where-Object { $_.browser_download_url -match '\.msi' } | Select-Object -First 1 -ExpandProperty browser_download_url

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $downloadUrl -OutFile "gauntlet.msi"

$hash = (Get-FileHash -Path "gauntlet.msi" -Algorithm SHA256).Hash

$version = $tagName.TrimStart('v')

(Get-Content gauntlet.nuspec) -replace '<version>(.+)</version>', "<version>$version.0</version>" | Set-Content gauntlet.nuspec

(Get-Content tools/chocolateyinstall.ps1) -replace 'download/v(.+)/gauntlet', "download/$tagName/gauntlet" | Set-Content tools/chocolateyinstall.ps1
(Get-Content tools/chocolateyinstall.ps1) -replace "checksum64     = '(.+)'", "checksum64     = '$hash'" | Set-Content tools/chocolateyinstall.ps1

git add gauntlet.nuspec tools/chocolateyinstall.ps1
git commit -m "Gauntlet $tagName"
git push

$sourceUrl = 'https://push.chocolatey.org/'
$apikey = $env:CHOCOLATEY_API_KEY

choco pack
choco apikey --api-key $apikey --source $sourceUrl
choco push gauntlet.$version.0.0.nupkg --source $sourceUrl
