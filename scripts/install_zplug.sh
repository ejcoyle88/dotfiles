#!/usr/bin/env bash
which -s zplug 
if [[ $? = 0 ]] ; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

