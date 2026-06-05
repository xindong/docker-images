ARG IMAGE_PLATFORM=linux/amd64
ARG BASE_REGISTRY=xindong
FROM --platform=$IMAGE_PLATFORM ${BASE_REGISTRY}/anaconda3:latest

ARG TENSORFLOW_VERSION=2.21.0
ARG TORCH_VERSION=2.12.0
ARG TORCHVISION_VERSION=0.27.0
ARG KERAS_VERSION=3.14.1
ARG FASTAI_VERSION=2.8.7
ARG H5PY_VERSION=3.16.0
ARG PYDOT_VERSION=4.0.1
ARG PIP_VERSION=26.1.2
ARG SETUPTOOLS_VERSION=82.0.1
ARG WHEEL_VERSION=0.47.0

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
    && conda clean -afy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
