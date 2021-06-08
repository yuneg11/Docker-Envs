VER=$1
CUDA=10.2
CUDNN=7
TYPE=devel
OSNAME=ubuntu18.04

TAG="$CUDA-cudnn$CUDNN-$TYPE"

docker build -t "basic-env:$TAG-$VER" \
             --build-arg "BASE_TAG=$TAG-$OSNAME" \
             .
