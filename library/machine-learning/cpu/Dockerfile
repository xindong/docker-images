FROM continuumio/anaconda3

RUN apt-get install -y graphviz && \
    pip install -U tensorflow==2.0.0-alpha0 && \
    conda install -y h5py && \
    pip install -U pydot keras && \
    conda install -y pytorch torchvision -c pytorch && \
    conda install -y fastai -c pytorch -c fastai 
