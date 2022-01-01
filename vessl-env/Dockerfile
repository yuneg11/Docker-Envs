ARG BASE_TAG
FROM nvidia/cuda:$BASE_TAG
MAINTAINER EungGu Yun <yuneg11@gmail.com>

# APT
RUN sed -i "s/archive.ubuntu.com/mirror.kakao.com/" /etc/apt/sources.list \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && DEBIAN_FRONTEND=noninteractive apt upgrade -y --no-install-recommends \
    && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
        sudo tmux ssh git vim htop zsh curl wget iputils-ping language-pack-en language-pack-ko ntp \
        python3.9 python3.9-distutils \
    && ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1 \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && rm -rf get-pip.py \
    && pip install jupyterlab

# SSH
EXPOSE 22

# User
RUN mkdir /home/vessl \
    && useradd -d /home/vessl -s /bin/bash vessl \
    && chown -R vessl:vessl /home/vessl

ARG PASSWD
RUN useradd -d /mnt/gsai/siml -s /bin/zsh siml \
    && echo "siml:$PASSWD" | chpasswd \
    && usermod -aG sudo siml
