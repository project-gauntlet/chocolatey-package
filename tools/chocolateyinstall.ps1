$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'msi'
  url64bit       = 'https://github.com/project-gauntlet/gauntlet/releases/download/v12/gauntlet-x86_64-windows.msi'
  softwareName   = 'Gauntlet'
  checksum64     = '90863e56f57bfb3217ed3c8da34f5429a0592c06cc0aeb3d4108427c47494bc0'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
