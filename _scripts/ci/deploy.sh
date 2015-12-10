#!/usr/bin/env bash

docker login -e "$DOCKER_EMAIL" -u "$DOCKER_USER" -p "$DOCKER_PASSWORD"
REGISTRY="" make push
docker login -e "$QUAY_EMAIL" -u "$QUAY_USER" -p "$QUAY_PASSWORD" quay.io
make push
