FROM xindong/anaconda3:5.3.0

LABEL image.tag="5.3.0"

RUN set -ex && \
    pip install -U pip && \
    conda install -y pytorch torchvision -c pytorch && \
    pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

