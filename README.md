# deis/go-dev

[![Build Status](https://github.com/deis/docker-go-dev/actions/workflows/docker-publish.yml/badge.svg)](https://quay.io/repository/deis/go-dev?tab=tags)

## ⚠ This project is deprecated ⚠

deis/go-dev is no longer actively maintained.

A [Go][] language development toolbox.

Some Azure projects use this Docker image as a standard build and test environment,
but it is intended to be useful to any Go developer. Please help make deis/go-dev better by
creating [issues][] and submitting [pull requests][].

## Image Contents

* based on [Ubuntu 22.04][]
* [az][]: Azure cloud command-line tool
* [azcopy][]: Utility for copying data to/from Microsoft Azure Blob and File storage
* [delve][]: debugger for the Go programming language
* [Docker][]: Docker binaries to be able to bind mount /var/run/docker.sock in the dev environment container
* [ginkgo][]: BDD testing framework for Go
* [go-bindata][]: converts any file into Go source code
* [golangci-lint][]: concurrent runner for Go linting tools
* [goss][]: YAML-based tool for validating a server's configuration
* [gox][]: simple Go cross-compiling tool
* [helm][]: Kubernetes package manager
* [jq][]: command-line JSON processor
* [jwt][]: tool for creating and parsing JSON Web Tokens
* [k][]: automatically run the correct version of `kubectl` every time
* [kubectl][]: Kubernetes command-line client
* [Packer][]: build automated machine images
* [ruby][]: ruby scripting language
* [shellcheck][]: static analysis for shell scripts
* [shfmt][]: shell script parser, formatter, and interpreter
* [shyaml][]: YAML access from the command line
* [test-cover.sh][]: test coverage for multiple Go packages
* [unzip][]: list, test, and extract files from ZIP archives
* [upx][]: executable packer
* [vim][]: text editor
* [wamerican][]: American English dictionary words for /usr/share/dict
* [yq][]: command-line YAML processor

## Usage

Mount your local Go code into a container's `$GOPATH` to run any `go` command or one of the
included tools or scripts. Here's an example of running `ginko` for deis/builder:

```console
$ docker run --rm \
  --volume $GOPATH/src/github.com/deis/builder:/go/src/github.com/deis/builder \
  --workdir /go/src/github.com/deis/builder \
  quay.io/deis/go-dev:latest \
  ginkgo -r
```

## Releases

The latest deis/go-dev Docker image is available at:

* [Microsoft Container Registry][]
  ```
  docker pull mcr.microsoft.com/oss/azcu/go-dev:<tag>
  ```
  Browse the [go-dev index URL][] to see which tags are available.

* [Quay.io][]
  ```
  docker pull quay.io/deis/go-dev
  ```

* [Docker Hub][]
  ```
  docker pull deis/go-dev
  ```

To publish a new release of deis/go-dev, use the [deisrel][] tool:

```console
$ deisrel release docker-go-dev v1.28.7
Doing a dry run of the component release...

Creating changelog for docker-go-dev with tag v1.28.6 through commit 1a69c5502ef1bca014fbd3581451d1421829a42f


### v1.28.6 -> v1.28.7
...
```

If the CHANGELOG contents look correct, run the same command again but add the argument `--dry-run=false`.
You will be prompted to confirm again before any tag or release is written to GitHub.


[az]: https://github.com/Azure/azure-cli#readme
[azcopy]: https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-linux?toc=%2fazure%2fstorage%2ffiles%2ftoc.json
[deisrel]: https://github.com/deis/deisrel
[delve]: https://github.com/go-delve/delve
[Docker Hub]: https://hub.docker.com
[Docker]: http://www.docker.com
[gen-changelog.sh]: https://github.com/deis/docker-go-dev/tree/master/rootfs/usr/local/bin/gen-changelog.sh
[ginkgo]: https://github.com/onsi/ginkgo
[go-bindata]: https://github.com/jteeuwen/go-bindata
[Go]: https://golang.org/
[go-dev index URL]: https://mcr.microsoft.com/v2/oss/azcu/go-dev/tags/list
[golangci-lint]: https://github.com/golangci/golangci-lint
[goss]: https://github.com/goss-org/goss
[gox]: https://github.com/mitchellh/gox
[helm]: https://github.com/kubernetes/helm
[issues]: https://github.com/deis/docker-go-dev/issues
[jq]: https://stedolan.github.io/jq/
[jwt]: https://github.com/dgrijalva/jwt-go
[k]: https://github.com/jakepearson/k
[kubectl]: https://kubernetes.io/docs/user-guide/kubectl-overview/
[Microsoft Container Registry]: https://github.com/microsoft/containerregistry
[pull requests]: https://github.com/deis/docker-go-dev/pulls
[Quay.io]: https://quay.io
[Packer]: https://github.com/hashicorp/packer
[ruby]: https://www.ruby-lang.org/
[shellcheck]: https://github.com/koalaman/shellcheck
[shfmt]: https://github.com/mvdan/sh
[shyaml]: https://github.com/0k/shyaml
[test-cover.sh]: https://github.com/deis/docker-go-dev/tree/master/rootfs/usr/local/bin/test-cover.sh
[Ubuntu 22.04]: https://hub.docker.com/_/ubuntu/
[unzip]: https://linux.die.net/man/1/unzip
[upx]: http://upx.sourceforge.net/
[vim]: http://www.vim.org/
[ruby]: https://www.ruby-lang.org/
[wamerican]: https://packages.ubuntu.com/xenial/wamerican
[yq]: https://github.com/mikefarah/yq
