FROM xindong/anaconda3-cuda:2019.03-10.0

RUN set -ex \
    && apt-get install -y graphviz \
    && pip install -U tensorflow-gpu==2.0.0-alpha0 \
    && conda install -y h5py \
    && pip install -U pydot keras \
    && conda install -y pytorch torchvision cudatoolkit=10.0 -c pytorch \
    && conda install -y fastai -c pytorch -c fastai
