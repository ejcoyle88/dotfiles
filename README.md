This repository contains my current set of dotfiles.

It uses [dotbot](https://github.com/anishathalye/dotbot) to symlink configuration files and run scripts
which are described in the .yaml files.

On windows it makes use of [scoop](https://scoop.sh) to install applications,
and uses [Homebrew](https://brew.sh) on OSX.

## Installation - Windows

1. Open an administrator PowerShell window with permission to run scripts.

Below is a snippet for allowing scripts in a PowerShell window.
```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

2. In the PowerShell window, run `./install.ps1`.
3. Open a GitBash window.
4. In the GitBash window, run `./install.sh`.

There is a separate set of PowerShell scripts in `config\vscode` for 
automatically installing a default set of VSCode extensions.

## Installation - Linux & OSX
Run `./install.sh`.

