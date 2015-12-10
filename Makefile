VERSION := $(shell git describe --tags --exact-match 2>/dev/null || echo latest)
REGISTRY ?= quay.io/
IMAGE_PREFIX ?= deis/
IMAGE := ${REGISTRY}${IMAGE_PREFIX}go-dev:${VERSION}

build:
	docker build -t ${IMAGE} rootfs

push: build
	docker push ${IMAGE}
