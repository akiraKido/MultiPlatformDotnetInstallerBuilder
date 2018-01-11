$ScriptPath = (Split-Path $MyInvocation.MyCommand.Path -Parent)

$Source = "$ScriptPath\..\src"
$CsProject = "$Source\MultiPlatformTest\MultiPlatformTest.csproj"
$PublishBasePath = "$Source\MultiPlatformTest\bin\Release\netcoreapp2.0"

$InstallerOutputPath = "$ScriptPath\installers\" + (Get-Date -Format yyyyMMdd-HHmm)

# installer scripts
$UbuntuInstallScript = "$ScriptPath\install-scripts\ubuntu.sh"

######################################################################
# BUILD
######################################################################

Write-Host "Start build" -ForegroundColor "Red"

Set-Location $Source

dotnet.exe clean
dotnet.exe restore
dotnet.exe build -c Release

[xml]$ProjectXml = Get-Content $CsProject
$Targets = $ProjectXml.Project.PropertyGroup.RuntimeIdentifiers.Split(";")
foreach($target in $Targets)
{
    Write-Host "Start $target publish" -ForegroundColor "Red"

    dotnet.exe publish --self-contained -c Release -r $target

    $OutputPath = "$InstallerOutputPath\$target"
    New-Item -ItemType Directory -Force -Path $OutputPath
    Copy-Item "$PublishBasePath\$target\publish" $OutputPath -Recurse

    if($target.Contains("ubuntu"))
    {
        Copy-Item $UbuntuInstallScript $OutputPath\install.sh
    }
}