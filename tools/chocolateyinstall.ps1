$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'msi'
  url64bit       = 'https://github.com/project-gauntlet/gauntlet/releases/download/v13/gauntlet-x86_64-windows.msi'
  softwareName   = 'Gauntlet'
  checksum64     = '54980F3515E8B90D9CC259F9621AECB7E8AC3B791372155E6AACB2A9FDF1098B'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
