# deis/go-dev

[![Build Status](https://travis-ci.org/deis/docker-go-dev.svg?branch=master)](https://travis-ci.org/deis/docker-go-dev) [![Docker Repository on Quay](https://quay.io/repository/deis/go-dev/status "Docker Repository on Quay")](https://quay.io/repository/deis/go-dev)

A [Go][] language development toolbox.

Many [Deis Workflow][] components use this Docker image as a standard build and test environment,
but it is intended to be useful to any Go developer. Please help make deis/go-dev better by
creating [issues][] and submitting [pull requests][].

## Image Contents

* based on the [official go Docker image][]
* [gen-changelog.sh][]: generate updates to CHANGELOG.md
* [ginkgo][]: BDD testing framework for go
* [glide][]: go dependency management
* [golint][]: go source code linter
* [gox][]: simple go cross-compiling tool
* [jq][]: command-line JSON processor
* [shellcheck][]: static analysis for shell scripts
* [test-cover.sh][]: test coverage for multiple go packages
* [upx][]: executable packer

## Usage

Mount your local go code into a container's `$GOPATH` to run any `go` command or one of the
included tools or scripts. Here's an example of running `glide up` for deis/builder:

```console
$ docker run --rm \
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

[Deis Workflow]: https://deis.com/
[Docker Hub]: https://hub.docker.com
[gen-changelog.sh]: https://github.com/deis/docker-go-dev/tree/master/rootfs/usr/local/bin/gen-changelog.sh
[ginkgo]: https://github.com/onsi/ginkgo
[glide]: https://github.com/Masterminds/glide
[Go]: https://golang.org/
[golint]: https://github.com/golang/lint
[gox]: https://github.com/mitchellh/gox
[issues]: https://github.com/deis/docker-go-dev/issues
[jq]: https://stedolan.github.io/jq/
[official go Docker image]: https://hub.docker.com/_/golang/
[pull requests]: https://github.com/deis/docker-go-dev/pulls
[Quay.io]: https://quay.io
[shellcheck]: https://github.com/koalaman/shellcheck
[test-cover.sh]: https://github.com/deis/docker-go-dev/tree/master/rootfs/usr/local/bin/test-cover.sh
[upx]: http://upx.sourceforge.net/
