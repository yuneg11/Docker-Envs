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
ARG DATE
ENV PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux
RUN cd /tmp \
    && wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && zcat < install-tl-unx.tar.gz | tar xf - \
    && cd install-tl-$DATE \
    && perl ./install-tl --no-interaction --scheme=small \
    && tlmgr install \
        latexmk enumitem xifthen ifmtarg datetime2 fontawesome5 sourcesanspro roboto \
        collection-langcjk collection-langkorean
