# Forked from https://github.com/bcardiff/docker-rclone

ARG IMAGE_PLATFORM=linux/amd64
FROM --platform=$IMAGE_PLATFORM alpine:3.23

ENV RCLONE_VERSION=v1.75.1
ENV ARCH=amd64
ENV SYNC_SRC=
ENV SYNC_DEST=
ENV SYNC_OPTS=-v
ENV RCLONE_OPTS="--config /config/rclone.conf"
ENV CRON=
ENV CRON_ABORT=
ENV FORCE_SYNC=
ENV CHECK_URL=
ENV TZ=

RUN set -ex \
    && apk add --no-cache ca-certificates curl dcron fuse lsof procps tzdata unzip \
    && curl -fsSL -o /tmp/rclone.zip \
        "https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip" \
    && unzip /tmp/rclone.zip -d /tmp \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin/rclone \
    && chmod +x /usr/bin/rclone \
    && rm -rf /tmp/rclone*

COPY entrypoint.sh /
COPY sync.sh /
COPY sync-abort.sh /

VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
