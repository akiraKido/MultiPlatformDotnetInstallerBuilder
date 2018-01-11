# .NET Core Multi-Platform Installer Builder

Creates a platform-specific installer for each platform specified in the target `.csproj`.

Currently available platforms:
- Ubuntu 16.04

## Dependencies

- .NET Core v2.0 or greater

## How to use

1. Place your source code into the `src` directory as done in this project.
    - This program currently assumes that you have one solution with one project.
1. Change the `$ProductName` to your Solution's name, i.e. the name of your `*.csproj`.
    - This program currently assumes that your Solution and Csproject have the same name.
1. Run `scripts\build.ps1` by opening a command prompt and running `..> powershell [path to scripts\build.ps1]`
1. Installers for each platform will be written in `\scripts\installers\yyyyMMdd-HHmm\*`.

## What the installer does

### Ubuntu

`scripts/install-scripts/ubuntu.sh`

- Copies the contents of `publish` into `/usr/bin/[ProductName]`.
    - `[ProductName]` corresponds to `$ProductName` in `scripts\build.ps1`
- Adds the directory as a PATH into `~/.profile` if necessary.
