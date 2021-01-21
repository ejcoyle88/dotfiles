This is my current set of dotfiles, using [dotbot]() and [chocolatey]() to quickly get up and running.

## Installation
First, open an administrator powershell window, and make sure that it's set up so that you can run scripts.

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

Then run `./InstallApps.ps1`. Once that completes all of the installations, open a git bash window, and run `.\install_dotfiles`.

There is a seperate set of scripts in `config\vscode` for automatically installing a default set of vscode extensions.