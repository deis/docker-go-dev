FROM ubuntu:16.04

LABEL name="deis-go-dev"

ENV AZCLI_VERSION=2.0.45 \
    GO_VERSION=1.11 \
    GLIDE_VERSION=v0.13.1 \
    GLIDE_HOME=/root \
    HELM_VERSION=v2.6.0 \
    KUBECTL_VERSION=v1.9.6 \
    SHELLCHECK_VERSION=v0.4.6 \
    ETCDCTL_VERSION=v3.1.8 \
    PATH=$PATH:/usr/local/go/bin:/go/bin:/usr/local/bin/docker \
    GOPATH=/go

# This is a huge one-liner to optimize the Docker image layer.
# We disable source repos to speed up apt-get update.
RUN \
  sed -i -e 's/^deb-src/#deb-src/' /etc/apt/sources.list && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get upgrade -y --no-install-recommends && \
  apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    ca-certificates \
    curl \
    git-core \
    jq \
    libffi-dev \
    libssl-dev \
    man \
    mercurial \
    net-tools \
    netcat \
    openssh-client \
    procps \
    python \
    python-dev \
    python-pip \
    python-setuptools \
    rsync \
    ruby \
    unzip \
    upx \
    util-linux \
    vim \
    wget \
    zip \
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
  && curl -sSL https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && curl -sSL https://storage.googleapis.com/kubernetes-helm/helm-$HELM_VERSION-linux-amd64.tar.gz \
    | tar -vxz -C /usr/local/bin --strip=1 \
  && mkdir -p /go/bin \
  && curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh \
  && wget https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod/pool/main/a/azcopy/azcopy_7.2.0-netcore_ubuntu16.04_x64.deb \
  && dpkg -i azcopy_7.2.0-netcore_ubuntu16.04_x64.deb || echo "missing dependencies" \
  && apt-get update && apt-get -f -y install \
  && curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz \
  && tar xzvf docker-17.05.0-ce.tgz -C /usr/local/bin \
  && chmod +x -R /usr/local/bin/docker \
  && rm docker-17.05.0-ce.tgz \
  && curl -L https://github.com/coreos/etcd/releases/download/$ETCDCTL_VERSION/etcd-$ETCDCTL_VERSION-linux-amd64.tar.gz -o /tmp/etcd-$ETCDCTL_VERSION.tar.gz \
  && tar -C /tmp -xvzf /tmp/etcd-$ETCDCTL_VERSION.tar.gz --strip-components=1 etcd-$ETCDCTL_VERSION-linux-amd64/etcdctl \
  && mv /tmp/etcdctl /usr/local/bin/etcdctl \
  && rm /tmp/etcd-$ETCDCTL_VERSION.tar.gz \
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
  && pip install --disable-pip-version-check --no-cache-dir azure-cli==${AZCLI_VERSION} shyaml \
  && apt-get purge --auto-remove -y libffi-dev python-dev python-pip \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc

WORKDIR /go

COPY . /
