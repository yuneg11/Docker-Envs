#!/bin/bash

if (( $# != 2 )); then
    echo "Usage $0 <VER> <PASSWD>"
    exit 0
else
    VER=$1
    PASSWD=$2
fi

CUDA=10.2
CUDNN=7
TYPE=devel
OSNAME=ubuntu18.04

TAG="$CUDA-cudnn$CUDNN-$TYPE"

docker build -t "ghcr.io/yuneg11/vessl-env:$VER" \
             --build-arg "BASE_TAG=$TAG-$OSNAME" \
             --build-arg "PASSWD=$PASSWD" \
             .
