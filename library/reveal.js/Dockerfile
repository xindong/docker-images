FROM alpine:latest

ARG REVEALJS_GITREPO='hakimel/reveal.js'
ARG REVEALJS_VERSION='3.7.0'

LABEL google-cloud-sdk.version=$REVEALJS_VERSION
LABEL image.tag=$REVEALJS_VERSION

RUN apk update -f && apk upgrade -f && \
    apk add --no-cache -f npm && \
    npm install -g npm@latest && \
    wget https://github.com/${REVEALJS_GITREPO}/archive/${REVEALJS_VERSION}.tar.gz && \
    tar xzf ${REVEALJS_VERSION}.tar.gz && \
    rm ${REVEALJS_VERSION}.tar.gz && \
    mv reveal.js-${REVEALJS_VERSION} reveal.js && \
    cd reveal.js && npm install

VOLUME ['/reveal.js/index.html', '/reveal.js/assets']

WORKDIR /reveal.js

ENTRYPOINT ["npm", "start"]
CMD ["--", "--port", "8000"]
