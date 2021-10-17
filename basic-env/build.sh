#!/bin/bash

if (( $# != 1 )); then
    echo "Usage $0 <VER>"
    exit 0
else
    VER=$1
fi

CUDA=10.2
CUDNN=7
TYPE=devel
OSNAME=ubuntu18.04

TAG="$CUDA-cudnn$CUDNN-$TYPE"

docker build -t "ghcr.io/yuneg11/basic-env:$TAG-$VER" \
             --build-arg "BASE_TAG=$TAG-$OSNAME" \
             .
