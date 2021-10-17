ARG BASE_TAG
FROM nvidia/cuda:$BASE_TAG
MAINTAINER EungGu Yun <yuneg11@gmail.com>

ARG USER_HOME="/root"

WORKDIR $USER_HOME

# APT
RUN sed -i "s/archive.ubuntu.com/mirror.kakao.com/" /etc/apt/sources.list \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt upgrade -y --no-install-recommends \
    && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
        tmux ssh git vim htop zsh curl wget iputils-ping language-pack-en language-pack-ko ntp \
    && ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# SSH
RUN echo "ALL: ALL" > /etc/hosts.allow \
    && mkdir ~/.ssh \
    && touch ~/.ssh/authorized_keys \
    && sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config \
    && (echo "root:root" | chpasswd)
EXPOSE 22

# ZSH
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/zsh-users/zsh-autosuggestions         ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-completions             ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git   ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
COPY zsh/ $USER_HOME/
RUN chsh -s /bin/zsh \
    && touch ~/.hushlogin

# GIT
COPY git/.gitignore $USER_HOME/
RUN git config --global core.excludesfile ~/.gitignore

# Postprocess
# ENTRYPOINT service ssh restart && zsh
