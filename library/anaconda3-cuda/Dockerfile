ARG IMAGE_PLATFORM=linux/amd64
FROM --platform=$IMAGE_PLATFORM nvidia/cuda:13.4.1-cudnn-devel-ubuntu24.04

ARG ANACONDA_VERSION=2026.07-1
ARG PIP_REVIEW_VERSION=1.3.0
ARG PYHAMCREST_VERSION=2.1.0
ARG PYCUDA_VERSION=2026.1
ARG JUPYTERTHEMES_VERSION=0.20.0
ARG PLOTLY_VERSION=6.8.0
ARG PIP_VERSION=26.2.1
ARG SETUPTOOLS_VERSION=84.0.0
ARG WHEEL_VERSION=0.48.0

LABEL anaconda.version=$ANACONDA_VERSION
LABEL cuda.version="13.4.1"
LABEL image.tag="2026.07-1-cuda13.4.1-cudnn"

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/conda/bin:/opt/conda/condabin:${PATH}

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        bzip2 \
        build-essential \
        ca-certificates \
        curl \
        git \
        tini \
    && curl -fsSL -o /tmp/anaconda.sh \
        "https://repo.anaconda.com/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh" \
    && bash /tmp/anaconda.sh -b -p /opt/conda \
    && rm /tmp/anaconda.sh \
    && python -m pip install --no-cache-dir --upgrade \
        "pip==${PIP_VERSION}" \
        "setuptools==${SETUPTOOLS_VERSION}" \
        "wheel==${WHEEL_VERSION}" \
    && python -m pip install --no-cache-dir \
        "pip-review==${PIP_REVIEW_VERSION}" \
        "PyHamcrest==${PYHAMCREST_VERSION}" \
        "pycuda==${PYCUDA_VERSION}" \
        "jupyterthemes==${JUPYTERTHEMES_VERSION}" \
        "plotly==${PLOTLY_VERSION}" \
    && jt -t grade3 -fs 10 -nfs 11 -tfs 12 -ofs 9 -dfs 9 \
    && conda clean -afy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]
