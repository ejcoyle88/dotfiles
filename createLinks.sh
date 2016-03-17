#!/usr/bin/env bash
SRC=$BASH_SOURCE

ln -s "$SRC/.vimrc" "~/.vimrc"
ln -s "$SRC/.vim" "~/.vim"

ln -s "$SRC/.tmux.conf" "~/.tmux.conf"
ln -s "$SRC/.tmux" "~/.tmux"
