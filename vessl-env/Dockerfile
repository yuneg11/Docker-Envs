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

# Conda
ARG CONDA_DIR
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/conda.sh \
    && bash /tmp/conda.sh -b -p $CONDA_DIR \
    && rm -f /tmp/conda.sh \
    && update-alternatives --install /usr/local/bin/conda   conda   $CONDA_DIR/bin/conda   1 \
    && update-alternatives --install /usr/local/bin/python  python  $CONDA_DIR/bin/python  1 \
    && update-alternatives --install /usr/local/bin/python3 python3 $CONDA_DIR/bin/python3 1 \
    && update-alternatives --install /usr/local/bin/pip     pip     $CONDA_DIR/bin/pip     1 \
    && update-alternatives --install /usr/local/bin/pip3    pip3    $CONDA_DIR/bin/pip3    1

# JupiterLab (to use in VESSL)
RUN pip install jupyterlab \
    && update-alternatives --install /usr/local/bin/jupyter jupyter $CONDA_DIR/bin/jupyter 1

# SSH
EXPOSE 22

# User
ARG PASSWD
RUN mkdir -p /siml \
    && useradd -d /siml/vessl -G root -s /bin/zsh -u 1001 -m vessl \
    && echo "vessl ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "vessl:$PASSWD" | chpasswd
# (1001 is the UID of `siml` in SIML cluster)

ENV PATH=/siml/vessl/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
RUN echo "PATH=$PATH" > /etc/environment

# VESSL internally executes init scripts which requires root privilege.
# USER vessl
