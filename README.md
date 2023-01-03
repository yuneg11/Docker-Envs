# Docker-Envs

## `vessl-env`

### Build

- Development build:
  ```bash
  cd vessl-env
  ./build.sh <PASSWD>  # TAG will be automatically set as `dev-yymmddHHMM`
  ```

- Release build:
  ```bash
  cd vessl-env
  ./build.sh <PASSWD> <TAG>
  ```

- Tag existing image:
  ```bash
  docker tag <IMAGE_ID> ghcr.io/<USER>/<REPO>:<TAG>
  ```

### Test

- Run container
  ```bash
  docker run -t -d <IMAGE_ID> /bin/sh
  ```

- Open shell in container
  ```bash
  docker exec -it <CONTAINER_ID> /bin/bash
  # or
  docker exec -it <CONTAINER_ID> /bin/zsh
  ```

- Stop container
  ```bash
  docker stop <CONTAINER_ID>
  ```

- Delete container
  ```bash
  docker rm <CONTAINER_ID>
  # or
  docker container rm <CONTAINER_ID>
  # or
  docker container prune  # remove all stopped containers
  ```

- Delete image
  ```bash
  docker rmi <IMAGE_ID>
  # or
  docker image rm <IMAGE_ID>
  ```

### Push image

- Register
  ```bash
  docker push ghcr.io/<USER>/<REPO>:<TAG>
  ```

- Delete
  ```bash
  curl -X DELETE https://ghcr.io/v2/ubuntu/manifests/sha256:<SHA256>
  ```
