#!/bin/bash

set -e

if [[ -z "${BUILD_SOURCEVERSION}" ]]; then

    npm install -g checksum

    mrcode_hash=$( git rev-parse HEAD )

    cd vscodium
    vscodium_hash=$( git rev-parse HEAD )

    cd vscode
    vscode_hash=$( git rev-parse HEAD )

    cd ../..

    export BUILD_SOURCEVERSION=$( echo "${mrcode_hash}:${vscodium_hash}:${vscode_hash}" | checksum )

    echo "Build version: ${BUILD_SOURCEVERSION}"

    # for GH actions
    if [[ $GITHUB_ENV ]]; then
        echo "BUILD_SOURCEVERSION=$BUILD_SOURCEVERSION" >> $GITHUB_ENV
    fi
fi

cd vscodium
