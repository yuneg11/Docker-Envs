DATE=$(date -u +%Y%m%d)

echo "Building latex-env:$DATE ..."

# Build
docker build -t ghcr.io/yuneg11/latex-env:$DATE - \
    --build-arg DATE=$DATE \
    < Dockerfile
