ARG IMAGE_PLATFORM=linux/amd64
FROM --platform=$IMAGE_PLATFORM alpine:3.23

ENV PATH=/usr/local/bin:$PATH
ENV LANG=C.UTF-8

ARG ALPINE_GLIBC_GITREPO=sgerrand/alpine-pkg-glibc
ARG ALPINE_GLIBC_VERSION=2.35-r1

LABEL alpine.version="3.23"
LABEL alpine-glibc.version=$ALPINE_GLIBC_VERSION
LABEL image.tag="latest"

RUN set -ex \
    && apk add --no-cache bash ca-certificates curl tini \
    && curl -fsSL -o /etc/apk/keys/sgerrand.rsa.pub \
        https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && base_url="https://github.com/${ALPINE_GLIBC_GITREPO}/releases/download/${ALPINE_GLIBC_VERSION}" \
    && curl -fsSLO "${base_url}/glibc-${ALPINE_GLIBC_VERSION}.apk" \
    && curl -fsSLO "${base_url}/glibc-bin-${ALPINE_GLIBC_VERSION}.apk" \
    && curl -fsSLO "${base_url}/glibc-i18n-${ALPINE_GLIBC_VERSION}.apk" \
    && apk add --no-cache \
        "glibc-${ALPINE_GLIBC_VERSION}.apk" \
        "glibc-bin-${ALPINE_GLIBC_VERSION}.apk" \
        "glibc-i18n-${ALPINE_GLIBC_VERSION}.apk" \
    && /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true \
    && echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh \
    && rm -f \
        /etc/apk/keys/sgerrand.rsa.pub \
        "glibc-${ALPINE_GLIBC_VERSION}.apk" \
        "glibc-bin-${ALPINE_GLIBC_VERSION}.apk" \
        "glibc-i18n-${ALPINE_GLIBC_VERSION}.apk" \
    && apk del glibc-i18n

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/bin/bash"]
