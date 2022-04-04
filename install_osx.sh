#!/usr/bin/env bash

CONFIG="install.osx.config.yaml"

set -e

DOTBOT_DIR="dotbot"
DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git
brew install --cask postman
brew install --cask jetbrains-toolbox
brew install --cask azure-data-studio
brew install --cask dotnet-sdk
brew install neovim
brew install nvm
brew install pyenv

brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-fira-mono-nerd-font

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

py -m pip install pynvim
