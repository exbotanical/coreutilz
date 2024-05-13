#!/usr/bin/env sh

docker container ls -a | grep coreutilz | awk '{ print $1 }' | xargs docker rm
docker image ls | grep coreutilz | awk '{ print $3 }' | xargs docker rmi
docker build -f Dockerfile.dev -t coreutilz .
docker run -it --entrypoint /bin/bash -v $(pwd):/usr/app coreutilz
