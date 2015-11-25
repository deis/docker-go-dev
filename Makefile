VERSION := 0.1.0
REGISTRY ?= quay.io
IMAGE_PREFIX ?= deis/
IMAGE := ${REGISTRY}/${IMAGE_PREFIX}go-dev:${VERSION}

build:
	docker build -t ${IMAGE} rootfs

push: build
	docker push ${IMAGE}
