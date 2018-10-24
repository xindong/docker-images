FROM xindong/anaconda3:5.3.0

LABEL image.tag="5.3.0"

RUN set -ex && \
    pip install -U pip pip-review PyHamcrest && \
    pip-review -a && \
    pip install -U jupyterthemes plotly && \
    conda install -y pytorch torchvision -c pytorch

