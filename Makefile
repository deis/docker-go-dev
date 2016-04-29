VERSION := $(shell git describe --tags --exact-match 2>/dev/null || echo latest)
REGISTRY ?= quay.io/
IMAGE_PREFIX ?= deis
IMAGE := ${REGISTRY}${IMAGE_PREFIX}/go-dev:${VERSION}

# scripts are checked *after* build, so use paths inside the container
SHELL_SCRIPTS = /usr/local/bin/gen-changelog.sh

# dockerized development environment variables
DEV_ENV_PREFIX := docker run --rm -e GO15VENDOREXPERIMENT=1
DEV_ENV_CMD := ${DEV_ENV_PREFIX} ${IMAGE}

build:
	docker build -t ${IMAGE} rootfs

push: build
	docker push ${IMAGE}

test: build
	${DEV_ENV_CMD} shellcheck $(SHELL_SCRIPTS)
