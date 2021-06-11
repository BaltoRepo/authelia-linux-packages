#!/usr/bin/env bash
# Build Debian packages for the given AUTHELIA_VERSION.
set -ex
if [ -z "${AUTHELIA_VERSION}" ]; then
  echo "AUTHELIA_VERSION env variable is required and not set."
  exit 1
fi
# Increment $DEB_REVISION every time you make a packaging change. Reset to 1 when $AUTHELIA_VERSION changes.
DEB_REVISION=${DEB_REVISION:-1}

PACKAGE_NAME="authelia"
PACKAGE_DESCRIPTION="The Single Sign-On Multi-Factor portal for web apps"
PACKAGE_URL="https://www.authelia.com/"

function package {
  ARCH=$1
  DOWNLOAD_ARCH=$ARCH
  if [ "${ARCH}" == "ppc64el" ]; then
    # Debian's arch ppc64el in Golang terms is ppc64le.
    DOWNLOAD_ARCH="ppc64le"
  elif [ "${ARCH}" == "armel" ]; then
    # Debian's arch armel in Golang terms is arm.
    DOWNLOAD_ARCH="arm"
  elif [ "${ARCH}" == "armhf" ]; then
    # Debian's arch armhf in Golang terms is arm32v7.
    DOWNLOAD_ARCH="arm32v7"
  elif [ "${ARCH}" == "arm64" ]; then
    # Debian's arch arm64 in Golang terms is arm64v8.
    DOWNLOAD_ARCH="arm64v8"
  elif [ "${ARCH}" == "i386" ]; then
    # Debian's arch i386 in Golang terms is 386.
    DOWNLOAD_ARCH="386"
  fi

  curl --location "https://github.com/authelia/authelia/releases/download/v${AUTHELIA_VERSION}/authelia-v${AUTHELIA_VERSION}-linux-${DOWNLOAD_ARCH}.tar.gz" --output tmp/authelia.tar.gz

  tar -xzvf tmp/authelia.tar.gz --directory tmp/

  rm -f ${PACKAGE_NAME}_${AUTHELIA_VERSION}-${DEB_REVISION}_${ARCH}.deb
  fpm \
    --input-type dir \
    --output-type deb \
    --name "${PACKAGE_NAME}" \
    --architecture "${ARCH}" \
    --version "${AUTHELIA_VERSION}-${DEB_REVISION}" \
    --maintainer 'Matt Fox <matt@getbalto.com>' \
    --url "${PACKAGE_URL}" \
    --description "${PACKAGE_DESCRIPTION}" \
    --after-install postinst.sh \
    --before-remove prerm.sh \
    tmp/authelia.service=/lib/systemd/system/authelia.service \
    tmp/config.template.yml=/etc/authelia/configuration.yml \
    tmp/authelia-linux-${DOWNLOAD_ARCH}=/usr/bin/authelia
}

rm -rf tmp/
mkdir -p tmp/

for ARCH in amd64 armhf arm64; do
  package ${ARCH}
done
