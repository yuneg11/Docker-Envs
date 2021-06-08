ARG BASE_TAG
FROM nvidia/cuda:$BASE_TAG
MAINTAINER EungGu Yun <yuneg11@gmail.com>

ARG USERHOME="/root"

WORKDIR $USERHOME

# APT
RUN sed -i "s/archive.ubuntu.com/mirror.kakao.com/" /etc/apt/sources.list \
    && apt update \
    && apt install -y --no-install-recommends \
    ssh git vim htop zsh curl wget language-pack-en language-pack-ko iputils-ping \
    && (DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends ntp \
        && ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime) \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# SSH
RUN echo "ALL: ALL" > /etc/hosts.allow \
    && mkdir $USERHOME/.ssh \
    && touch $USERHOME/.ssh/authorized_keys \
    && sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config \
    && (echo "root:root" | chpasswd)
EXPOSE 22

# ZSH
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
COPY zsh/ $USERHOME/
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN chsh -s /bin/zsh \
    && touch ~/.hushlogin
    # && update-locale

# GIT
COPY git/.gitignore $USERHOME/

RUN git config --global core.excludesfile ~/.gitignore

# Postprocess
ENTRYPOINT service ssh restart && zsh
