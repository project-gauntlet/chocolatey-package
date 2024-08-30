$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'msi'
  url64bit       = 'https://github.com/project-gauntlet/gauntlet/releases/download/v7/gauntlet-x86_64-windows.msi'
  softwareName   = 'Gauntlet'
  checksum64     = '60a203a99a368f76c3fe9f39c90faddeb6bacf40410c1e6c58a1b110c2f3d70a'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
