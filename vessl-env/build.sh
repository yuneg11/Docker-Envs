#!/bin/bash

if (( $# == 0 )); then
    echo "Usage $0 <PASSWD> [<VER>]"
    exit 0
elif (( $# == 1 )); then
    PASSWD=$1
    VER="dev-$(date +%y%m%d%H%M)"
else
    PASSWD=$1
    VER=$2
fi

echo "Building vessl-env:$VER ..."

CUDA=11.5.1
CUDNN=8
TYPE=devel
OSNAME=ubuntu20.04

TAG="$CUDA-cudnn$CUDNN-$TYPE"

docker build -t "ghcr.io/yuneg11/vessl-env:$VER" \
             --build-arg "BASE_TAG=$TAG-$OSNAME" \
             --build-arg "PASSWD=$PASSWD" \
             .
