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

# Base image
CUDA="11.7.1"
CUDNN="8"
TYPE="devel"
OSNAME="ubuntu22.04"

BASE_TAG="$CUDA-cudnn$CUDNN-$TYPE-$OSNAME"

# Build arguments
CONDA_DIR="/usr/local/anaconda3"

# Build
docker build -t "ghcr.io/yuneg11/vessl-env:$VER" \
             --build-arg "BASE_TAG=$BASE_TAG" \
             --build-arg "PASSWD=$PASSWD" \
             --build-arg "CONDA_DIR=$CONDA_DIR" \
             .
