#!/usr/bin/env bash
SRC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#SRC=$(dirname "$BASH_SOURCE")

ln -sf $SRC/.vimrc ~/.vimrc
ln -sf $SRC/.vim ~/.vim

ln -sf $SRC/.tmux.conf ~/.tmux.conf
ln -sf $SRC/.tmux ~/.tmux
