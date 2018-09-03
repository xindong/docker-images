FROM alpine:latest

ENV PATH /usr/local/google-cloud-sdk/bin:$PATH

RUN apk update -f && apk upgrade -f && \
    apk --no-cache add -f bash curl ca-certificates coreutils openssl socat tini \
        git jq libc6-compat openssh-client python py-crcmod && \
    rm -rf /var/cache/apk/* && \
    # query latest version of google-cloud-sdk by downloading
    wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz && \
    tar xzf google-cloud-sdk.tar.gz && \
    export CLOUD_SDK_VERSION=`cat google-cloud-sdk/VERSION` && \
    rm -fr google-cloud-sdk google-cloud-sdk.tar.gz && \
    # download latest version
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    mv google-cloud-sdk /usr/local && \
    ln -s /lib /lib64 && \
    # install all components
    components=`gcloud components list --format=json 2>/dev/null \
        | jq '[.[] | { id: .id , installed: .state.name } | select(.installed == "Not Installed") | .id ]' \
        | jq -r '. | join(" ")'` && \
    gcloud -q components install $components && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version
VOLUME ["/root/.config"]
