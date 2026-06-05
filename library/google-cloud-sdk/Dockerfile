ARG IMAGE_PLATFORM=linux/amd64
ARG BASE_REGISTRY=xindong
FROM --platform=$IMAGE_PLATFORM ${BASE_REGISTRY}/alpine-base:latest

ARG CLOUD_SDK_VERSION=570.0.0

ENV PATH=/usr/local/google-cloud-sdk/bin:$PATH

LABEL google-cloud-sdk.version=$CLOUD_SDK_VERSION
LABEL image.tag=$CLOUD_SDK_VERSION

RUN set -ex \
    && apk add --no-cache \
        bash \
        ca-certificates \
        coreutils \
        curl \
        git \
        openssh-client \
        openssl \
        py3-crcmod \
        python3 \
        socat \
    && curl -fsSL -o /tmp/google-cloud-sdk.tar.gz \
        "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" \
    && tar xzf /tmp/google-cloud-sdk.tar.gz -C /usr/local \
    && rm /tmp/google-cloud-sdk.tar.gz \
    && ln -sf /lib /lib64 \
    && gcloud -q components install beta alpha \
    && gcloud config set core/disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true \
    && gcloud config set metrics/environment github_docker_image \
    && gcloud version

VOLUME ["/root/.config"]
