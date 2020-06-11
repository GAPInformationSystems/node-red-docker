#!/bin/bash
# export NODE_RED_VERSION=$(grep -oE "\"node-red\": \"(\w*.\w*.\w*.\w*.\w*.)" package.json | cut -d\" -f4)

export OS="buster-slim" # alpine | buster-slim | stretch-slim


rm -rf ./node-red-contrib-saprfc;
cp -r ~/Documents/GitHub/node-red-contrib-saprfc ./;

docker build --no-cache \
    --build-arg ARCH=amd64 \
    --build-arg NODE_VERSION=12 \
    --build-arg OS=$OS \
    --build-arg BUILD_DATE="$(date +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg TAG_SUFFIX=default \
    --file dockerfile.compile \
    --tag pwieland/gto:saprfc-compile-test .

# docker rmi $(docker images -aq --filter dangling=true)