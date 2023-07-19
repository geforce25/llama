FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ENV DEBIAN_FRONTEND noninteractive
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/cuda-12.2/lib64:/usr/local/cuda-12.2/include
ENV PATH /usr/local/cuda-12.2/bin/:$PATH

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get update
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt install -y python3.11
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1
RUN apt-get install python3-distutils python3-apt
RUN apt-get install -y curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.11 get-pip.py
RUN apt install -y libpython3.11-dev

RUN pip install --upgrade pip

RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

COPY . /home/ai/llama
WORKDIR /home/ai/llama/

RUN pip install -e .
