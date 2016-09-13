FROM quay.io/deis/base:0.3.1

ENV GO_VERSION=1.7.1 \
    GLIDE_VERSION=v0.12.1 \
    GLIDE_HOME=/root \
    PATH=$PATH:/usr/local/go/bin:/go/bin \
    GOPATH=/go

RUN apt-get update && apt-get install -y \
  jq \
  man \
  upx \
  zip \
  git \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && curl -L https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar -C /usr/local -xz \
  && curl -sSL https://github.com/Masterminds/glide/releases/download/$GLIDE_VERSION/glide-$GLIDE_VERSION-linux-amd64.tar.gz \
    | tar -vxz -C /usr/local/bin --strip=1 \
  && curl -L https://s3-us-west-2.amazonaws.com/get-deis/shellcheck-0.4.3-linux-amd64 -o /usr/local/bin/shellcheck \
  && chmod +x /usr/local/bin/shellcheck \
  && go get -u -v \
  github.com/alecthomas/gometalinter \
  github.com/onsi/ginkgo/ginkgo \
  github.com/mitchellh/gox \
  && gometalinter --install

WORKDIR /go

COPY . /
