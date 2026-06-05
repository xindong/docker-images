ARG IMAGE_PLATFORM=linux/amd64
FROM --platform=$IMAGE_PLATFORM ubuntu:24.04

ARG ANACONDA_VERSION=2025.12-2

LABEL anaconda.version=$ANACONDA_VERSION
LABEL image.tag=$ANACONDA_VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/conda/bin:/opt/conda/condabin:${PATH}

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        bzip2 \
        ca-certificates \
        curl \
        tini \
    && curl -fsSL -o /tmp/anaconda.sh \
        "https://repo.anaconda.com/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh" \
    && bash /tmp/anaconda.sh -b -p /opt/conda \
    && rm /tmp/anaconda.sh \
    && conda clean -afy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["python", "-V"]
