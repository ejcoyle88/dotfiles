$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

mklink %HOMEPATH%\.vimrc $scriptPath\.vimrc
mklink %HOMEPATH%\.vim $scriptPath\.vim
mklink %HOMEPATH%\.tmux.config $scriptPath\.tmux.config
mklink %HOMEPATH%\.tmux $scriptPath\.tmux
