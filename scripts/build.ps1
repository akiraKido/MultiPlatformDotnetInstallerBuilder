# Copyright (c) 2017 Akira Kido
# https://github.com/akiraKido

# Permission is hereby granted, free of charge, to any person obtaining a 
# copy of this software and associated documentation files (the 
# "Software"), to deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, merge, publish, 
# distribute, sublicense, and/or sell copies of the Software, and to 
# permit persons to whom the Software is furnished to do so, subject to 
# the following conditions:

# The above copyright notice and this permission notice shall be 
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

$ProductName = "MultiPlatformTest"

# install paths for each platform
$UbuntuProductPath = "/usr/bin/$ProductName"

$ScriptPath = (Split-Path $MyInvocation.MyCommand.Path -Parent)

$Source = "$ScriptPath\..\src"
$CsProject = "$Source\$ProductName\$ProductName.csproj"
$PublishBasePath = "$Source\$ProductName\bin\Release\netcoreapp2.0"

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

        $data = Get-Content $OutputPath\install.sh
        $data[1] = $data[1] + "`nINSTALL_PATH=`"$UbuntuProductPath`""
        $data | Out-File $OutputPath\install.sh
    }
}