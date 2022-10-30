ARG BASE_TAG
FROM nvidia/cuda:$BASE_TAG
MAINTAINER EungGu Yun <yuneg11@gmail.com>

# APT
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i "s/archive.ubuntu.com/mirror.kakao.com/" /etc/apt/sources.list \
    && apt update \
    && apt install -y --no-install-recommends software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt upgrade -y --no-install-recommends \
    && apt install -y --no-install-recommends \
        sudo tmux ssh git vim htop zsh curl wget rsync less iputils-ping ntp \
        python3.10 python3.10-dev python3.10-distutils language-pack-en language-pack-ko \
        tree fd-find fasd fzf ranger ncdu tig bat neofetch exa duf \
    && ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && ln -fs /usr/bin/fdfind /usr/bin/fd \
    && update-alternatives --install /usr/bin/bat bat /usr/bin/batcat 1 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && rm -rf get-pip.py \
    && pip install jupyterlab

# SSH
EXPOSE 22

# User
RUN useradd -d /home/dummy -s /bin/bash dummy

ARG PASSWD
RUN mkdir -p /siml \
    && useradd -d /siml/vessl -G root -s /bin/zsh -m vessl \
    && echo "vessl ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "vessl:$PASSWD" | chpasswd

ENV PATH=/siml/vessl/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
RUN echo "PATH=$PATH" > /etc/environment

# VESSL internally executes init scripts which requires root privilege.
# USER vessl
