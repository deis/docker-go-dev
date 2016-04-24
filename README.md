# deis/go-dev

[![Build Status](https://travis-ci.org/deis/docker-go-dev.svg?branch=master)](https://travis-ci.org/deis/docker-go-dev) [![Docker Repository on Quay](https://quay.io/repository/deis/go-dev/status "Docker Repository on Quay")](https://quay.io/repository/deis/go-dev)

## Summary
The go-dev docker container provides a lightweight Go development environment for use by Deis contributors.  Many Deis component builds delegate to containers based on this image, thereby eliminating the need for contributors to install and manage any specific set of development tools and version thereof. Although created for use with Deis development, this image may prove generally useful to the Go community.

## Image Contents

* based on the [official go Docker image][]
* [ginkgo][]: BDD testing framework for go
* [glide][]: go dependency management
* [golint][]: go source code linter
* [gox][]: simple go cross-compiling tool
* [shellcheck][]: static analysis for shell scripts
* [upx][]: executable packer

## Usage

Mount your local go code into a container's `$GOPATH` to run any `go` command or one of the
included tools or scripts. Here's an example of running `glide up` for deis/builder:

```console
$ docker run --rm \
  --env GO15VENDOREXPERIMENT=1 \
  --volume $GOPATH/src/github.com/deis/builder:/go/src/github.com/deis/builder \
  --workdir /go/src/github.com/deis/builder \
  quay.io/deis/go-dev:latest \
  glide up
```

The latest deis/go-dev Docker image is available at:

* [Quay.io][]
  ```
  docker pull quay.io/deis/go-dev
  ```

* [Docker Hub][]
  ```
  docker pull deis/go-dev
  ```

[Docker Hub]: https://hub.docker.com
[ginkgo]: https://github.com/onsi/ginkgo
[glide]: https://github.com/Masterminds/glide
[golint]: https://github.com/golang/lint
[gox]: https://github.com/mitchellh/gox
[official go Docker image]: https://hub.docker.com/_/golang/
[Quay.io]: https://quay.io
[shellcheck]: https://github.com/koalaman/shellcheck
[upx]: http://upx.sourceforge.net/
