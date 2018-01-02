#!/usr/bin/env bash

docker login -u "$DOCKER_USER" -p "$DOCKER_PASSWORD"
REGISTRY="" make push
docker login -u "$QUAY_USER" -p "$QUAY_PASSWORD" quay.io
make push
