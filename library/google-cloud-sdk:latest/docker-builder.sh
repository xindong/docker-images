#!/bin/bash

die() {
    printf '%s\n' "$1" >&2
    exit 1
}

[ `command -v jq` != "" ] || die "please install \`jq\`"

IMAGE_ID_FILE="./.Image_ID"
ORGNIZATION="xindong"

cd `dirname $0`
# query latest version of google-cloud-sdk by downloading
wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz && \
tar xzf google-cloud-sdk.tar.gz && \
CLOUD_SDK_VERSION=`cat google-cloud-sdk/VERSION` && \
rm -fr google-cloud-sdk google-cloud-sdk.tar.gz && \
IMAGE_TAG='latest' && \
docker build \
    --build-arg CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION \
    --label image.tag=$IMAGE_TAG \
    --iidfile $IMAGE_ID_FILE \
    . && \
docker tag `cat $IMAGE_ID_FILE` $ORGNIZATION/google-cloud-sdk:$IMAGE_TAG && \
rm $IMAGE_ID_FILE && \
echo $IMAGE_TAG
