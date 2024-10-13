$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'msi'
  url64bit       = 'https://github.com/project-gauntlet/gauntlet/releases/download/v10/gauntlet-x86_64-windows.msi'
  softwareName   = 'Gauntlet'
  checksum64     = '76abdec4f662535478cde75ee3b3546d61af1475c979db2603264f3cc4be9458'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
