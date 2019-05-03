FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

ENV PATH /opt/conda/bin:/opt/conda/condabin:${PATH}
ENV DEBIAN_FRONTEND noninteractive

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends build-essential nvidia-driver-418 cuda-10-0 wget curl git \
    && apt-get install -y --no-install-recommends nvinfer-runtime-trt-repo-ubuntu1804-5.0.2-ga-cuda10.0 \
        && apt-get update \
        && apt-get install -y --no-install-recommends libnvinfer5=5.1.2-1+cuda10.0 libnvinfer-dev=5.1.2-1+cuda10.0 \
        && apt-mark hold libnvinfer5 libnvinfer-dev \
    && wget -O ~/anaconda.sh --quiet https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh \
    && /bin/sh ~/anaconda.sh -b -p /opt/conda \
    && rm ~/anaconda.sh \
    && pip install -U pip pip-review PyHamcrest pycuda jupyterthemes plotly \
    && pip-review -a \
    && jt -t grade3 -fs 10 -nfs 11 -tfs 12 -ofs 9 -dfs 9

ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "/bin/bash" ]
