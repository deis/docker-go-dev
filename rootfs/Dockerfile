FROM ubuntu:18.04

LABEL name="deis-go-dev" \
      maintainer="Matt Boersma <matt.boersma@microsoft.com>"

ENV AZCLI_VERSION=2.9.0 \
    DOCKER_VERSION=19.03.4 \
    GO_VERSION=1.14.6 \
    GLIDE_VERSION=v0.13.3 \
    GLIDE_HOME=/root \
    HELM_VERSION=v2.16.7 \
    KUBECTL_VERSION=v1.16.3 \
    ETCDCTL_VERSION=v3.1.8 \
    GOLANGCI_LINT_VERSION=v1.28.3 \
    PROTOBUF_VERSION=3.7.0 \
    SHELLCHECK_VERSION=v0.7.1 \
    SHFMT_VERSION=3.1.2 \
    PATH=$PATH:/usr/local/go/bin:/go/bin:/usr/local/bin/docker \
    GOPATH=/go

# This is a huge one-liner to optimize the Docker image layer.
# We disable source repos to speed up apt-get update.
RUN \
  sed -i -e 's/^deb-src/#deb-src/' /etc/apt/sources.list && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:rmescandon/yq && \
  apt-add-repository --yes --update ppa:ansible/ansible && \
  apt-get update && \
  apt-get upgrade -y --no-install-recommends && \
  apt-get install -y --no-install-recommends \
    ansible \
    bash \
    build-essential \
    ca-certificates \
    curl \
    git-core \
    jq \
    libffi-dev \
    libicu60 \
    libssl-dev \
    libunwind8 \
    man \
    mercurial \
    net-tools \
    netcat \
    openssh-client \
    procps \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    rsync \
    ruby \
    unzip \
    upx \
    util-linux \
    vim \
    wamerican \
    wget \
    yq \
    zip \
  && curl -L https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xz \
  && curl -sSL https://github.com/Masterminds/glide/releases/download/${GLIDE_VERSION}/glide-${GLIDE_VERSION}-linux-amd64.tar.gz \
    | tar -vxz -C /usr/local/bin --strip=1 \
  && curl -sSL -o /tmp/protoc.zip https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip \
  && unzip /tmp/protoc.zip 'bin/protoc' -d /usr/local \
  && rm /tmp/protoc.zip \
  && curl -sSL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && mkdir -p ${GOPATH}/src/k8s.io/helm \
  && curl -sSL https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    | tar -vxz -C /usr/local/bin --strip=1 \
  && mkdir -p /go/bin \
  && curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh \
  && curl -sSL https://aka.ms/downloadazcopy-v10-linux | tar -vxz -C /usr/local/bin --strip=1 \
  && mv /usr/local/bin/azcopy /usr/local/bin/azcopy-preview \
  && curl -sSL https://aka.ms/downloadazcopylinux64 | tar -vxz -C /tmp \
  && /tmp/install.sh \
  && apt-get update && apt-get -f -y install \
  && curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
  && tar xzvf docker-${DOCKER_VERSION}.tgz -C /usr/local/bin \
  && chmod +x -R /usr/local/bin/docker \
  && rm docker-${DOCKER_VERSION}.tgz \
  && curl -L https://github.com/coreos/etcd/releases/download/${ETCDCTL_VERSION}/etcd-${ETCDCTL_VERSION}-linux-amd64.tar.gz -o /tmp/etcd-${ETCDCTL_VERSION}.tar.gz \
  && tar -C /tmp -xvzf /tmp/etcd-${ETCDCTL_VERSION}.tar.gz --strip-components=1 etcd-${ETCDCTL_VERSION}-linux-amd64/etcdctl \
  && mv /tmp/etcdctl /usr/local/bin/etcdctl \
  && rm /tmp/etcd-${ETCDCTL_VERSION}.tar.gz \
  && go get -u -v \
    github.com/AlekSi/gocov-xml \
    github.com/axw/gocov/gocov \
    github.com/constabulary/gb/... \
    github.com/derekparker/delve/cmd/dlv \
    github.com/dgrijalva/jwt-go/cmd/jwt \
    github.com/golang/protobuf/protoc-gen-go \
    github.com/haya14busa/goverage \
    github.com/jteeuwen/go-bindata/... \
    github.com/mitchellh/gox \
    github.com/onsi/ginkgo/ginkgo \
    github.com/hashicorp/packer \
    gopkg.in/alecthomas/gometalinter.v2 \
  && ln -s ${GOPATH}/bin/gometalinter.v2 ${GOPATH}/bin/gometalinter \
  && gometalinter.v2 --install \
  && curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b ${GOPATH}/bin ${GOLANGCI_LINT_VERSION} \
  && curl -sSL https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz \
    | tar -vxJ -C /usr/local/bin --strip=1 \
  && curl -o /usr/local/bin/shfmt -sSL https://github.com/mvdan/sh/releases/download/v{SHFMT_VERSION}/shfmt_v{SHFMT_VERSION}_linux_amd64 \
  && chmod +x /usr/local/bin/shfmt \
  && pip3 install --disable-pip-version-check --no-cache-dir azure-cli==${AZCLI_VERSION} shyaml \
  && apt-get purge --auto-remove -y libffi-dev python3-dev \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc ${GOPATH}/pkg/* ${GOPATH}/src/* /root/cache /root/.cache \
  && go clean -cache -testcache -modcache

WORKDIR /go

COPY . /
