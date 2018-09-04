#!/bin/bash

die() {
    printf '%s\n' "$1" >&2
    exit 1
}

[ `command -v jq` != "" ] || die "please install \`jq\`"

IMAGE_ID_FILE="./.Image_ID"
ORGNIZATION="xindong"
ALPINE_GLIBC_REPO="sgerrand/alpine-pkg-glibc"
ALPINE_GLIBC_VERSION=`wget --quiet -O - https://api.github.com/repos/$ALPINE_GLIBC_REPO/releases/latest | jq -r '.["tag_name"]'`

cd `dirname $0` && \
IMAGE_TAG='latest' && \
docker build \
    --build-arg ALPINE_GLIBC_GITREPO=$ALPINE_GLIBC_REPO \
    --build-arg ALPINE_GLIBC_VERSION=$ALPINE_GLIBC_VERSION \
    --label image.tag=$IMAGE_TAG \
    --iidfile $IMAGE_ID_FILE \
    . && \
docker tag `cat $IMAGE_ID_FILE` $ORGNIZATION/alpine-base:$IMAGE_TAG && \
rm $IMAGE_ID_FILE && \
echo $IMAGE_TAG
