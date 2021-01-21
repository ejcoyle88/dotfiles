# Install 'scoop' (scoop.sh)
if (!(Get-Command "scoop" -errorAction SilentlyContinue))
{
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

# Add the extras bucket
scoop bucket add extras
# Add the nerd-fonts bucket for installing nice fonts
scoop bucket add nerd-fonts
# Add the jetbrains bucket
scoop bucket add JetBrains

# Fonts
scoop install FiraCode
scoop install FiraMono-NF
# Utilities
scoop install 7zip
scoop install windows-terminal
scoop install ag
# Browsers
scoop install chromium
# VCS
scoop install git
scoop install openssh
scoop install pshazz # Fancy powershell prompt & links ssh password to windows credentials store
scoop install winmerge
# Password management
scoop install keepass
# REST clients
scoop install insomnia
scoop install postman
# AWS Tools
scoop install aws # aws-cli
scoop install serverless # serverless framework cli
# dotnet
scoop install dotnet-sdk
scoop install linqpad
# Editors
scoop install neovim
scoop install Rider
# Other languages
scoop install python
scoop install nvm # node version manager

py -m pip install pynvim