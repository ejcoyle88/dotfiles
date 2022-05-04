#!/usr/bin/env bash

git submodule update --init --recursive 

set -e

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
    ./dotbot/bin/dotbot -d . --plugin-dir "dotbot-brew" -c "${CONFIG}" "${@}" -v
    exit 1
else
    CONFIG="install.conf.yaml"
fi


./dotbot/bin/dotbot -d . -c "${CONFIG}" "${@}" -v
