#!/usr/bin/env bash
# Push to Balto Repo
set -e
if [ -z "${DEB_VERSION}" ]; then
  echo "DEB_VERSION env variable is required and not set."
  exit 1
fi
if [ -z "${PUSH_TOKEN}" ]; then
  echo "PUSH_TOKEN env variable is required and not set."
  exit 1
fi
REPO_UPLOAD=${REPO_UPLOAD:-https://authelia.baltorepo.com/stable/debian/upload/}

function push {
  FILE=$1

  curl \
    --verbose \
    --http1.1 \
    --progress-bar \
    --header "Authorization: Bearer ${PUSH_TOKEN}" \
    --form "package=@${FILE}" \
    --form "readme=<repo-readme.md" \
    --form distribution=all \
    "${REPO_UPLOAD}"
}

for FILE in $(ls authelia_${DEB_VERSION}_*.deb); do
  push $FILE
done
