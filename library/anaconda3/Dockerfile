FROM xindong/alpine-base:latest

LABEL image.tag="2019.03"

ENV PATH /anaconda3/bin:${PATH}

RUN set -ex && \
    wget -O ~/anaconda.sh --quiet https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh && \
    /bin/sh ~/anaconda.sh -b -p /anaconda3 && \
    rm ~/anaconda.sh

ENTRYPOINT ["/anaconda3/bin/python"]
CMD ["-V"]
