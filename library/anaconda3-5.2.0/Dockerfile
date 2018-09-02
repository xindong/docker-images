FROM xindong/alpine-base:latest

RUN set -ex && \
    wget -O ~/anaconda.sh --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh && \
    /bin/sh ~/anaconda.sh -b -p /usr/local/anaconda3 && \
    rm ~/anaconda.sh

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
