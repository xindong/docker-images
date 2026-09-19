FROM node:26.9.0-alpine3.23

ARG REVEALJS_GITREPO=hakimel/reveal.js
ARG REVEALJS_VERSION=6.0.2

LABEL revealjs.version=$REVEALJS_VERSION
LABEL image.tag=$REVEALJS_VERSION

RUN set -ex \
    && apk add --no-cache ca-certificates curl tar \
    && curl -fsSL -o /tmp/revealjs.tar.gz \
        "https://github.com/${REVEALJS_GITREPO}/archive/${REVEALJS_VERSION}.tar.gz" \
    && tar xzf /tmp/revealjs.tar.gz -C /tmp \
    && mv "/tmp/reveal.js-${REVEALJS_VERSION}" /reveal.js \
    && rm /tmp/revealjs.tar.gz \
    && cd /reveal.js \
    && npm install \
    && npm cache clean --force

VOLUME ["/reveal.js/index.html", "/reveal.js/assets"]

WORKDIR /reveal.js

ENTRYPOINT ["npm", "start"]
CMD ["--", "--port", "8000"]
