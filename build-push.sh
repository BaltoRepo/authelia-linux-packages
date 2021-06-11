#!/usr/bin/env bash
set -e

export AUTHELIA_VERSION=$1

if [ -z "${AUTHELIA_VERSION}" ]; then
    echo "Error: authelia version is required as first argument"
    exit 1
fi
export DEB_PACKAGE=authelia
export DEB_VERSION=${AUTHELIA_VERSION}-1

./build-deb.sh
./test-deb.sh
./push.sh
