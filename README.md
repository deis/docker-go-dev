#deis/go-dev

docker-go-dev is the source for the `deis/go-dev` Docker image available at [quay.io](https://quay.io).

__NOTE: This is an _experimental_ branch that bases the dev environment on Alpine Linux in order to promote a smaller image size.  Alpine's `libc` implementation is purported to be non-standard and problematic.  Your mileage from this branch, or the Docker image built from it, may vary.__

Its purpose is to provide a lightweight Go development environment for use by Deis contributors.  Many Deis component builds delegate to containers based on this image, thereby eliminating the need for contributors to install and manage any specific set of development tools and version thereof.

At present the image just contains:

* go (from the official golang:1.5.1-alpine image)
* Additional packages:
  * openssl
	* build-base
	* git
	* mercurial (with some minimal configuration)
* glide (for go dependency management)

Although created for use with Deis development, this image may prove generally useful to the Go community.
