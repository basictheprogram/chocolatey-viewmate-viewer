$errorActionPreference = 'Stop';

$fullPackage = "ViewMate_Setup.zip"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'ftp://ftp.pentalogix.com/' + $fullPackage
$workSpace = Join-Path $env:TEMP $env:ChocolateyPackageName 
$installer = Join-Path $toolsDir $fullPackage

$ftpFileArgs = @{
  packageName = $packageName
  fileName    = $installer

  url         = $url
  username    = 'viewmate'
  password    = 'download'
}

Get-FtpFile @ftpFileArgs

$unzipFileArgs = @{
  fileFullpath = $installer
  destination  = $toolsDir
}

Get-ChocolateyUnzip @unzipFileArgs

$autoitExe = 'C:\Program Files (x86)\AutoIt3\AutoIt3.exe'
$autoitFile = Join-Path $toolsDir 'viewmate.au3'
$fileFullPath = Join-Path $toolsDir 'ViewMate_Setup.exe'

Start-ChocolateyProcessAsAdmin  -ExeToRun $autoitExe -Statements "$autoitFile $fileFullPath"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'ViewMate*'
  fileType       = 'EXE'
  file           = Join-Path $toolsDir 'ViewMate_Setup.exe'
  
  checksum       = 'f394a3956e487d67611e0b8be1c6fcba7b50c0cb93391436844103323872b09a'
  checksumType   = 'sha256'

  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/qn /norestart'
}
