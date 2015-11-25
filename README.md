#deis/go-dev

docker-go-dev is the source for the `deis/go-dev` Docker image available at [quay.io](https://quay.io).

Its purpose is to provide a lightweight Go development environment for use by Deis contributors.  Many Deis component builds delegate to containers based on this image, thereby eliminating the need for contributors to install and manage any specific set of development tools and version thereof.

At present the image just contains:

* go (from the golang:1.5.1 image)
* glide (for go dependency management)

Although created for use with Deis development, this image may prove generally useful to the Go community.
