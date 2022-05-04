#!/usr/bin/env bash

PLUGINS=""
if [[ "$OSTYPE" == "msys" ]]; then
    if ! [[ $(sfc 2>&1 | tr -d '\0') =~ SCANNOW ]]; then
        echo "This command must be run as an administrator";
        exit 1
    fi
    # Enable symlinks in gitbash
    export MSYS=winsymlinks:nativestrict
    CONFIG="install.win.conf.yaml"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    CONFIG="install.osx.conf.yaml"

    PLUGINS="--plugin-dir dotbot-brew"
    git -C "dotbot-brew" submodule sync --quiet --recursive
    git submodule update --init --recursive "dotbot-brew"
else
    CONFIG="install.conf.yaml"
fi

set -e

DOTBOT_DIR="dotbot"
DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" ${PLUGINS} -c "${CONFIG}" "${@}"
