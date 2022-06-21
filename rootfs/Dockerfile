FROM ubuntu:20.04

LABEL name="deis-go-dev" \
  maintainer="Matt Boersma <matt.boersma@microsoft.com>"

ARG TARGETOS
ARG TARGETARCH
ENV ANSIBLE_VERSION=5.9.0 \
  AZCLI_VERSION=2.33.1 \
  DOCKER_VERSION=20.10.2 \
  ETCDCTL_VERSION=v3.4.8 \
  GO_VERSION=1.17.11 \
  GOLANGCI_LINT_VERSION=v1.45.2 \
  GOSS_VERSION=v0.3.18 \
  HELM_VERSION=3.6.2 \
  KUBECTL_VERSION=v1.21.3 \
  PACKER_VERSION=1.7.3 \
  PROTOBUF_VERSION=3.7.0 \
  PYJWT_VERSION=2.1.0 \
  PYWINRM_VERSION=0.4.3 \
  SHELLCHECK_VERSION=v0.8.0 \
  SHFMT_VERSION=3.4.2 \
  UPX_VERSION=3.96 \
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
  libc6 \
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
  util-linux \
  vim \
  wamerican \
  wget \
  yq \
  zip \
  && curl -L https://golang.org/dl/go${GO_VERSION}.${TARGETOS}-${TARGETARCH}.tar.gz | tar -C /usr/local -xz \
  && if [ "${TARGETARCH}"="arm64" ]; \
    then \
        curl -sSL -o /tmp/protoc.zip https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-aarch_64.zip \
  		  && unzip /tmp/protoc.zip 'bin/protoc' -d /usr/local \
 		    && rm /tmp/protoc.zip ;\
    else  \
        curl -sSL -o /tmp/protoc.zip https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip \
  		  && unzip /tmp/protoc.zip 'bin/protoc' -d /usr/local \
 		    && rm /tmp/protoc.zip ; fi\
  && curl -sSL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && mkdir -p ${GOPATH}/src/k8s.io/helm \
  && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
  && chmod 700 get_helm.sh && ./get_helm.sh --version v${HELM_VERSION} \
  && rm ./get_helm.sh \
  && mkdir -p /go/bin \
  && curl -sSL https://aka.ms/downloadazcopy-v10-linux | tar -vxz -C /usr/local/bin --strip=1 \
  && mv /usr/local/bin/azcopy /usr/local/bin/azcopy-preview \
  && curl -sSL https://aka.ms/downloadazcopylinux64 | tar -vxz -C /tmp \
  && /tmp/install.sh \
  && apt-get update && apt-get -f -y install \
  && if [ "${TARGETARCH}"="arm64" ]; \
    then \
      curl -fsSLO https://download.docker.com/linux/static/stable/aarch64/docker-${DOCKER_VERSION}.tgz \
        && tar xzvf docker-${DOCKER_VERSION}.tgz -C /usr/local/bin \
        && chmod +x -R /usr/local/bin/docker \
        && rm docker-${DOCKER_VERSION}.tgz ;\
    else  \
      curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
        && tar xzvf docker-${DOCKER_VERSION}.tgz -C /usr/local/bin \
        && chmod +x -R /usr/local/bin/docker \
        && rm docker-${DOCKER_VERSION}.tgz ;fi\
  && curl -L https://github.com/coreos/etcd/releases/download/${ETCDCTL_VERSION}/etcd-${ETCDCTL_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz -o /tmp/etcd-${ETCDCTL_VERSION}.tar.gz \
  && tar -C /tmp -xvzf /tmp/etcd-${ETCDCTL_VERSION}.tar.gz --strip-components=1 etcd-${ETCDCTL_VERSION}-${TARGETOS}-${TARGETARCH}/etcdctl \
  && mv /tmp/etcdctl /usr/local/bin/etcdctl \
  && rm /tmp/etcd-${ETCDCTL_VERSION}.tar.gz \
  && go get -u -v \
  github.com/AlekSi/gocov-xml \
  github.com/axw/gocov/gocov \
  github.com/go-delve/delve/cmd/dlv \
  github.com/dgrijalva/jwt-go/cmd/jwt \
  github.com/golang/protobuf/protoc-gen-go \
  github.com/haya14busa/goverage \
  github.com/jteeuwen/go-bindata/... \
  github.com/mitchellh/gox \
  github.com/onsi/ginkgo/ginkgo \
  && curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b ${GOPATH}/bin ${GOLANGCI_LINT_VERSION} \
  && if [ "${TARGETARCH}"="arm64" ]; \
    then \
        curl -sSL https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.aarch64.tar.xz|tar -vxJ -C /usr/local/bin --strip=1 ;\
    else  \
        curl -sSL https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz|tar -vxJ -C /usr/local/bin --strip=1 ; fi \
  && curl -sSL https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_${TARGETOS}_${TARGETARCH}.zip -o /tmp/packer.zip \
  && unzip /tmp/packer.zip -d /usr/local/bin \
  && curl -o /usr/local/bin/shfmt -sSL https://github.com/mvdan/sh/releases/download/v{SHFMT_VERSION}/shfmt_v{SHFMT_VERSION}_${TARGETOS}_${TARGETARCH} \
  && chmod +x /usr/local/bin/shfmt \
  && curl -L "https://github.com/aelsabbahy/goss/releases/download/${GOSS_VERSION}/goss-${TARGETOS}-${TARGETARCH}" -o /usr/local/bin/goss \
  && chmod +rx /usr/local/bin/goss \
  && curl -L "https://github.com/aelsabbahy/goss/releases/download/${GOSS_VERSION}/dgoss" -o /usr/local/bin/dgoss \
  && chmod +rx /usr/local/bin/dgoss \
  && curl -sSL -o /tmp/upx.tar.xz https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-${TARGETARCH}_${TARGETOS}.tar.xz \
  && tar -xvf /tmp/upx.tar.xz -C /tmp \
  && mv /tmp/upx-${UPX_VERSION}-${TARGETARCH}_${TARGETOS}/upx /usr/local/bin/upx \
  && pip3 install --disable-pip-version-check --no-cache-dir --upgrade pip \
  && pip3 install --disable-pip-version-check --no-cache-dir --upgrade azure-cli==${AZCLI_VERSION} PyJWT==${PYJWT_VERSION} shyaml pywinrm==${PYWINRM_VERSION} \
  && pip3 install --disable-pip-version-check --no-cache-dir --upgrade ansible==${ANSIBLE_VERSION} ansible-core==2.12.6 --force-reinstall \
  && ansible-galaxy collection install ansible.windows:==1.10.0 \
  && apt-get purge --auto-remove -y libffi-dev python3-dev \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc ${GOPATH}/pkg/* ${GOPATH}/src/* /root/cache /root/.cache \
  && go clean -cache -testcache -modcache

WORKDIR /go

COPY . /