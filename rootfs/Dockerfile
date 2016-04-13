FROM golang:1.6.0

ENV GO15VENDOREXPERIMENT=1
ENV GLIDE_HOME=/root

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
  jq \
  man \
  upx \
  zip \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && curl -L https://github.com/Masterminds/glide/releases/download/0.10.1/glide-0.10.1-linux-amd64.tar.gz | tar xvz \
  && mv linux-amd64/glide /usr/local/bin/ \
  && rm -rf linux-amd64 \
  && curl -L https://s3-us-west-2.amazonaws.com/get-deis/shellcheck-0.4.3-linux-amd64 -o /usr/local/bin/shellcheck \
  && chmod +x /usr/local/bin/shellcheck \
  && go get -u -v \
  github.com/golang/lint/golint \
  github.com/onsi/ginkgo/ginkgo \
  github.com/pwaller/goupx \
  github.com/mitchellh/gox

WORKDIR /go

COPY . /
