#!/usr/bin/env bash
which -s omz
if [[ $? = 0 ]] ; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
