ARG IMAGE_PLATFORM=linux/amd64
ARG BASE_REGISTRY=xindong
FROM --platform=$IMAGE_PLATFORM ${BASE_REGISTRY}/anaconda3:latest

ARG TENSORFLOW_VERSION=2.21.0
ARG TORCH_VERSION=2.14.0
ARG TORCHVISION_VERSION=0.29.0
ARG KERAS_VERSION=3.15.1
ARG FASTAI_VERSION=2.8.12
ARG H5PY_VERSION=3.14.0
ARG PYDOT_VERSION=4.0.1
ARG PYHAMCREST_VERSION=2.1.0
ARG JUPYTERTHEMES_VERSION=0.20.0
ARG PLOTLY_VERSION=6.8.0
ARG PIP_VERSION=26.2.1
ARG SETUPTOOLS_VERSION=84.0.0
ARG WHEEL_VERSION=0.48.0

LABEL image.tag="latest"

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends graphviz \
    && python -m pip install --no-cache-dir --upgrade \
        "pip==${PIP_VERSION}" \
        "setuptools==${SETUPTOOLS_VERSION}" \
        "wheel==${WHEEL_VERSION}" \
    && python -m pip install --no-cache-dir \
        "tensorflow==${TENSORFLOW_VERSION}" \
        "torch==${TORCH_VERSION}" \
        "torchvision==${TORCHVISION_VERSION}" \
        "keras==${KERAS_VERSION}" \
        "fastai==${FASTAI_VERSION}" \
        "h5py==${H5PY_VERSION}" \
        "pydot==${PYDOT_VERSION}" \
        "PyHamcrest==${PYHAMCREST_VERSION}" \
        "jupyterthemes==${JUPYTERTHEMES_VERSION}" \
        "plotly==${PLOTLY_VERSION}" \
    && jt -t grade3 -fs 10 -nfs 11 -tfs 12 -ofs 9 -dfs 9 \
    && conda clean -afy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
