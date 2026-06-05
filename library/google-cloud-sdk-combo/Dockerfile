ARG IMAGE_PLATFORM=linux/amd64
ARG BASE_REGISTRY=xindong
FROM --platform=$IMAGE_PLATFORM ${BASE_REGISTRY}/google-cloud-sdk:latest

LABEL image.tag="latest"

RUN set -ex \
    && apk add --no-cache jq \
    && components="$(gcloud components list --format=json 2>/dev/null \
        | jq '[.[] | {id: .id, installed: .state.name} | select(.installed == "Not Installed") | .id]' \
        | jq -r 'join(" ")')" \
    && if [ -n "$components" ]; then gcloud -q components install $components; fi \
    && gcloud version
