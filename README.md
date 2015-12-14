# deis/go-dev

[![Build Status](https://travis-ci.org/deis/docker-go-dev.svg?branch=master)](https://travis-ci.org/deis/docker-go-dev) [![Docker Repository on Quay](https://quay.io/repository/deis/go-dev/status "Docker Repository on Quay")](https://quay.io/repository/deis/go-dev)

## Summary 
The go-dev docker container provides a lightweight Go development environment for use by Deis contributors.  Many Deis component builds delegate to containers based on this image, thereby eliminating the need for contributors to install and manage any specific set of development tools and version thereof. Although created for use with Deis development, this image may prove generally useful to the Go community.

## Image Contents

* based on the [official go Docker image](https://hub.docker.com/_/golang/)
* [glide](https://github.com/Masterminds/glide): go dependency management

## Usage

The latest Docker image is available via:

* [Quay.io](https://quay.io)
  ```
  docker pull quay.io/deis/go-dev
  ```

* [Docker Hub](https://hub.docker.com)
  ```
  docker pull deis/go-dev
  ```


