$errorActionPreference = 'Stop';

$data = & (Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Path) -ChildPath data.ps1)
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installer = Join-Path $toolsDir 'ViewMate_Setup.exe'

$packageArgs = @{
    packageName  = $env:ChocolateyPackageName
    fileFullPath = Join-Path $toolsDir 'ViewMate_Setup.zip'
    softwareName = 'ViewMate*'

    url          = $data.url
    checksum     = $data.checksum
    checksumType = $data.checksumType
}

Get-ChocolateyWebFile @packageArgs

$unzipFileArgs = @{
    fileFullpath = Join-Path $toolsDir 'ViewMate_Setup.zip'
    destination  = $toolsDir
}

Get-ChocolateyUnzip @unzipFileArgs

$autoitExe = 'C:\Program Files (x86)\AutoIt3\AutoIt3.exe'
$autoitFile = Join-Path $toolsDir 'viewmate.au3'
$fileFullPath = Join-Path $toolsDir 'ViewMate_Setup.exe'

Start-ChocolateyProcessAsAdmin  -ExeToRun $autoitExe -Statements "$autoitFile $fileFullPath"
