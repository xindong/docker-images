FROM xindong/alpine-base:latest

LABEL image.tag="5.3.0"

ENV PATH ${PATH}:/usr/local/anaconda3/bin

RUN set -ex && \
    wget -O ~/anaconda.sh --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh && \
    /bin/sh ~/anaconda.sh -b -p /usr/local/anaconda3 && \
    rm ~/anaconda.sh

ENTRYPOINT ['/usr/local/anaconda3/bin/python']
CMD ['-V']
