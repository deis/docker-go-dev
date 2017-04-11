FROM quay.io/deis/base:v0.3.6

ENV GO_VERSION=1.8.1 \
    GLIDE_VERSION=v0.12.3 \
    GLIDE_HOME=/root \
    SHELLCHECK_VERSION=v0.4.6 \
    PATH=$PATH:/usr/local/go/bin:/go/bin \
    GOPATH=/go

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  git-core \
  mercurial \
  util-linux \
  jq \
  man \
  unzip \
  upx \
  zip \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && curl -L https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar -C /usr/local -xz \
  && curl -sSL https://github.com/Masterminds/glide/releases/download/$GLIDE_VERSION/glide-$GLIDE_VERSION-linux-amd64.tar.gz \
    | tar -vxz -C /usr/local/bin --strip=1 \
  && curl -L https://deisbuildartifacts.blob.core.windows.net/shellcheck/shellcheck-${SHELLCHECK_VERSION}-linux-amd64 -o /usr/local/bin/shellcheck \
  && chmod +x /usr/local/bin/shellcheck \
  && curl -L https://storage.googleapis.com/k8s-claimer/git-e4dcc16/k8s-claimer-git-e4dcc16-linux-amd64 -o /usr/local/bin/k8s-claimer \
	&& chmod +x /usr/local/bin/k8s-claimer \
  && curl -sSL -o /tmp/protoc.zip https://github.com/google/protobuf/releases/download/v3.1.0/protoc-3.1.0-linux-x86_64.zip \
  && unzip /tmp/protoc.zip 'bin/protoc' -d /usr/local \
  && rm /tmp/protoc.zip \
  && apt-get purge -y --auto-remove \
    unzip \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc \
  && go get -u -v \
  github.com/alecthomas/gometalinter \
  github.com/onsi/ginkgo/ginkgo \
  github.com/mitchellh/gox \
  github.com/golang/protobuf/protoc-gen-go \
  && gometalinter --install

WORKDIR /go

COPY . /
