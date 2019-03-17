FROM xindong/alpine-base:latest

LABEL image.tag="2018.12"

ENV PATH /anaconda3/bin:${PATH}

RUN set -ex && \
    wget -O ~/anaconda.sh --quiet https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh && \
    /bin/sh ~/anaconda.sh -b -p /anaconda3 && \
    rm ~/anaconda.sh

ENTRYPOINT ["/anaconda3/bin/python"]
CMD ["-V"]
