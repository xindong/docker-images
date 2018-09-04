FROM xindong/alpine-base:latest

ENV PATH /usr/local/google-cloud-sdk/bin:$PATH

ARG CLOUD_SDK_VERSION

LABEL google-cloud-sdk.version=$CLOUD_SDK_VERSION
LABEL image.tag=$CLOUD_SDK_VERSION

RUN apk update -f && apk upgrade -f && \
    apk --no-cache add -f bash curl ca-certificates coreutils openssl socat \
        git openssh-client python py-crcmod && \
    rm -rf /var/cache/apk/* && \
    # download latest version
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    mv google-cloud-sdk /usr/local && \
    ln -s /lib /lib64 && \
    # install all components
    gcloud -q components install beta alpha && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud version

VOLUME ["/root/.config"]
