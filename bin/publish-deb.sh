#!/bin/bash -ex

GIT_HASH=$(git rev-parse HEAD | cut -c -7)
VERSION=0.${BUILD_NUMBER:-0}.0-h${BUILD_NUMBER:-0}.${GIT_HASH}
DEB_FILE=newrelic-testapp_${VERSION}_all.deb
METADATA="deb_distribution=trusty;deb_component=main;publish=1;deb_architecture=i386,amd64"

REPO="debians-dev"
if [[ "${BRANCH_NAME}" == "master" ]]; then
  REPO="debians"
fi

BINTRAY_URL=https://api.bintray.com/content/armory/${REPO}

curl -T ./build/distributions/${DEB_FILE} \
  -u${BINTRAY_USER}:${BINTRAY_APIKEY} \
   "${BINTRAY_URL}/newrelic-testapp/${VERSION}/${DEB_FILE};${METADATA}"
