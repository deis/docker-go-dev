FROM quay.io/deis/base:v0.3.5

ENV GO_VERSION=1.7.3 \
    GLIDE_VERSION=v0.12.3 \
    GLIDE_HOME=/root \
    PATH=$PATH:/usr/local/go/bin:/go/bin \
    GOPATH=/go

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  git-core \
  mercurial \
  util-linux \
  jq \
  man \
  upx \
  zip \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && curl -L https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar -C /usr/local -xz \
  && curl -sSL https://github.com/Masterminds/glide/releases/download/$GLIDE_VERSION/glide-$GLIDE_VERSION-linux-amd64.tar.gz \
    | tar -vxz -C /usr/local/bin --strip=1 \
  && curl -L https://s3-us-west-2.amazonaws.com/get-deis/shellcheck-0.4.3-linux-amd64 -o /usr/local/bin/shellcheck \
  && chmod +x /usr/local/bin/shellcheck \
  && curl -L https://storage.googleapis.com/k8s-claimer/git-e4dcc16/k8s-claimer-git-e4dcc16-linux-amd64 -o /usr/local/bin/k8s-claimer \
	&& chmod +x /usr/local/bin/k8s-claimer \
  && go get -u -v \
  github.com/alecthomas/gometalinter \
  github.com/onsi/ginkgo/ginkgo \
  github.com/mitchellh/gox \
  && gometalinter --install

WORKDIR /go

COPY . /
