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
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Masterminds/glide/releases/download/0.10.1/glide-0.10.1-linux-amd64.tar.gz && \
  tar xvfz glide-0.10.1-linux-amd64.tar.gz && \
  mv linux-amd64/glide /usr/local/bin/ && \
  rm -rf linux-amd64 glide-0.10.1-linux-amd64.tar.gz

RUN go get -u -v \
  github.com/golang/lint/golint \
  github.com/onsi/ginkgo/ginkgo \
  github.com/pwaller/goupx \
  github.com/mitchellh/gox

WORKDIR /go

COPY . /
