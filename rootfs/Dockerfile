FROM golang:1.6.2

ENV GLIDE_VERSION=v0.11.1 GLIDE_HOME=/root GO15VENDOREXPERIMENT=1

RUN apt-get update && apt-get install -y \
  jq \
  man \
  upx \
  zip \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && curl -sSL https://github.com/Masterminds/glide/releases/download/$GLIDE_VERSION/glide-$GLIDE_VERSION-linux-amd64.tar.gz \
    | tar -vxz -C /usr/local/bin --strip=1 \
  && curl -L https://s3-us-west-2.amazonaws.com/get-deis/shellcheck-0.4.3-linux-amd64 -o /usr/local/bin/shellcheck \
  && chmod +x /usr/local/bin/shellcheck \
  && go get -u -v \
  github.com/golang/lint/golint \
  github.com/onsi/ginkgo/ginkgo \
  github.com/mitchellh/gox

WORKDIR /go

COPY . /
