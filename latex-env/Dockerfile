FROM ubuntu:24.04

# DEV ENV
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i "s/archive.ubuntu.com/mirror.kakao.com/" /etc/apt/sources.list \
    && apt update \
    && apt install -y -U --no-install-recommends \
        git wget perl ca-certificates libfontconfig \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Setup LaTeX
ENV PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux
RUN cd /tmp \
    && wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && zcat < install-tl-unx.tar.gz | tar xf - \
    && cd $(find . -type d -name 'install-tl-*') \
    && perl ./install-tl --no-interaction
