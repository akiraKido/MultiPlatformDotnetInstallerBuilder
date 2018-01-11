# .NET Core Multi-Platform Installer Builder

Creates a platform-specific installer for each platform specified in the target `.csproj`.

Currently available platforms:
- Ubuntu 16.04

## Dependencies

- .NET Core v2.0 or greater

## How to use

1. Place your source code into the `src` directory as done in this project.
1. Change the `$CsProject` and `$PublishBasePath` variables in `scripts\build.ps1` to appropriate values.
1. Run `scripts\build.ps1` by opening a command prompt and running `..> powershell [path to scripts\build.ps1]`
1. Installers for each platform will be written in `\scripts\installers\yyyyMMdd-HHmm\*`.

## What this actually does

By running `scripts\build.ps1`, the following occurs:

1. Cleans and builds the target project using the `dotnet` command.
1. Publishes for each platform specified in the `RuntimeIdentifiers` tag in the csproj.
1. Copies the installer script into each installer directory.

## What the installer does

### Ubuntu

- Copies the contents of `publish` into `/usr/bin/[name]`
    - Edit `scripts/install-scripts/ubuntu.sh` to change [name]
- Adds the directory as a PATH into `~/.profile`
