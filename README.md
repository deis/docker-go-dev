# deis/go-dev

[![Build Status](https://travis-ci.org/deis/docker-go-dev.svg?branch=master)](https://travis-ci.org/deis/docker-go-dev) [![Docker Repository on Quay](https://quay.io/repository/deis/go-dev/status "Docker Repository on Quay")](https://quay.io/repository/deis/go-dev)

A [Go][] language development toolbox.

Many [Deis Workflow][] components use this Docker image as a standard build and test environment,
but it is intended to be useful to any Go developer. Please help make deis/go-dev better by
creating [issues][] and submitting [pull requests][].

## Image Contents

* based on [Ubuntu 16.04][]
* [az][]: Azure cloud command-line tool
* [azcopy][]: Utility for copying data to/from Microsoft Azure Blob and File storage
* [dep][]: Go dependency management tool
* [delve][]: debugger for the Go programming language
* [Docker][]: Docker binaries to be able to bind mount /var/run/docker.sock in the dev environment container
* [gb][]: project-based build tool for Go
* [ginkgo][]: BDD testing framework for Go
* [glide][]: Go dependency management tool
* [go-bindata][]: converts any file into Go source code
* [golint][]: Go source code linter
* [gometalinter][]: run Go lint tools concurrently
* [golangci-lint][]: concurrent runner for Go linting tools
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
## Usage

Mount your local Go code into a container's `$GOPATH` to run any `go` command or one of the
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

[az]: https://github.com/Azure/azure-cli#readme
[azcopy]: https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-linux?toc=%2fazure%2fstorage%2ffiles%2ftoc.json
[Deis Workflow]: https://deis.com/
[delve]: https://github.com/derekparker/delve
[dep]: https://github.com/golang/dep
[Docker Hub]: https://hub.docker.com
[Docker]: http://www.docker.com
[gb]: https://github.com/constabulary/gb/
[gen-changelog.sh]: https://github.com/deis/docker-go-dev/tree/master/rootfs/usr/local/bin/gen-changelog.sh
[ginkgo]: https://github.com/onsi/ginkgo
[glide]: https://github.com/Masterminds/glide
[go-bindata]: https://github.com/jteeuwen/go-bindata
[Go]: https://golang.org/
[golint]: https://github.com/golang/lint
[gometalinter]: https://github.com/alecthomas/gometalinter
[golangci-lint]: https://github.com/golangci/golangci-lint
[gox]: https://github.com/mitchellh/gox
[helm]: https://github.com/kubernetes/helm
[issues]: https://github.com/deis/docker-go-dev/issues
[jq]: https://stedolan.github.io/jq/
[jwt]: https://github.com/dgrijalva/jwt-go
[k]: https://github.com/jakepearson/k
[kubectl]: https://kubernetes.io/docs/user-guide/kubectl-overview/
[pull requests]: https://github.com/deis/docker-go-dev/pulls
[Quay.io]: https://quay.io
[Packer]: https://github.com/hashicorp/packer
[ruby]: https://www.ruby-lang.org/
[shellcheck]: https://github.com/koalaman/shellcheck
[shfmt]: https://github.com/mvdan/sh
[shyaml]: https://github.com/0k/shyaml
[test-cover.sh]: https://github.com/deis/docker-go-dev/tree/master/rootfs/usr/local/bin/test-cover.sh
[Ubuntu 16.04]: https://hub.docker.com/_/ubuntu/
[unzip]: https://linux.die.net/man/1/unzip
[upx]: http://upx.sourceforge.net/
[vim]: http://www.vim.org/
[ruby]: https://www.ruby-lang.org/
[wamerican]: https://packages.ubuntu.com/xenial/wamerican
