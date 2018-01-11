# .NET Core Multi-Platform Installer Builder

Creates a platform-specific installer for each platform specified in the target `.csproj`.

Currently available platforms:
- Ubuntu 16.04

## How to use

1. Place your source code into the `src` directory as done in this project.
1. Change the `$CsProject` and `$PublishBasePath` variables in `script\build.ps1` to appropriate values.
1. Run `script\build.ps1` by opening a command prompt and running `..> powershell [path to scripts\build.ps1]`
1. Installers for each platform will be written in `\scripts\installers\yyyyMMdd-HHmm\*`.
