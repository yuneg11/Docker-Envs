ARG BASE_TAG
FROM nvidia/cuda:$BASE_TAG
MAINTAINER EungGu Yun <yuneg11@gmail.com>

ARG TEMPLATE_HOME="/etc/skel"

# APT
RUN sed -i "s/archive.ubuntu.com/mirror.kakao.com/" /etc/apt/sources.list \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && DEBIAN_FRONTEND=noninteractive apt upgrade -y --no-install-recommends \
    && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
        sudo ssh git vim htop zsh curl wget iputils-ping language-pack-en language-pack-ko ntp \
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

# ZSH
RUN ZSH="/etc/skel/.oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/zsh-users/zsh-autosuggestions         ${ZSH_CUSTOM:-$TEMPLATE_HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$TEMPLATE_HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-completions             ${ZSH_CUSTOM:-$TEMPLATE_HOME/.oh-my-zsh/custom}/plugins/zsh-completions
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git   ${ZSH_CUSTOM:-$TEMPLATE_HOME/.oh-my-zsh/custom}/themes/powerlevel10k
COPY zsh/ $TEMPLATE_HOME/

COPY git/.gitignore $TEMPLATE_HOME/
RUN touch $TEMPLATE_HOME/.hushlogin

# User
ARG USER_NAME="siml"
RUN mkdir /home/vessl \
    && useradd -m vessl -s /bin/bash \
    && echo "vessl:vessl" | chpasswd \
    && chown -R vessl:vessl /home/vessl
RUN useradd -m $USER_NAME -s /bin/zsh \
    && echo "$USER_NAME:$USER_NAME" | chpasswd \
    && usermod -aG sudo siml
