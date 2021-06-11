#!/usr/bin/env bash
# In a Docker container, install the package and run Authelia.
set -ex
if [ -z "$DEB_VERSION" ]; then
  echo "DEB_VERSION env variable is required and not set."
  exit 1
fi
DEB_PACKAGE=authelia
ARCH=${ARCH:-amd64}
WD=$(pwd)/

PACKAGE="${DEB_PACKAGE}_${DEB_VERSION}_${ARCH}.deb"
# jrei/systemd-debian is Debian with systemd
docker container run \
  --rm \
  --env PACKAGE=${PACKAGE} \
  --mount type=bind,source=${WD},destination=/opt/,readonly \
  "jrei/systemd-debian:10" \
  bash /opt/deb-install-in-docker.sh
