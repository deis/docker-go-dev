FROM quay.io/deis/base:v0.3.6

ENV AZCLI_VERSION=2.0.14 \
    GO_VERSION=1.9.2 \
    GLIDE_VERSION=v0.13.1 \
    GLIDE_HOME=/root \
    HELM_VERSION=v2.6.0 \
    KUBECTL_VERSION=v1.8.0 \
    SHELLCHECK_VERSION=v0.4.6 \
    PATH=$PATH:/usr/local/go/bin:/go/bin:/usr/local/bin/docker \
    GOPATH=/go

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  git-core \
  mercurial \
  util-linux \
  jq \
  libffi-dev \
  libssl-dev \
  man \
  python \
  python-dev \
  python-pip \
  python-setuptools \
  unzip \
  upx \
  zip \
  openssh-client \
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
  && curl -sSL https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && curl -sSL https://storage.googleapis.com/kubernetes-helm/helm-$HELM_VERSION-linux-amd64.tar.gz \
    | tar -vxz -C /usr/local/bin --strip=1 \
  && apt-get purge -y --auto-remove \
    unzip \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc \
  && curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz \
  && tar xzvf docker-17.05.0-ce.tgz -C /usr/local/bin \
  && chmod +x -R /usr/local/bin/docker \
  && rm docker-17.05.0-ce.tgz \
  && go get -u -v \
  github.com/alecthomas/gometalinter \
  github.com/onsi/ginkgo/ginkgo \
  github.com/mitchellh/gox \
  github.com/golang/protobuf/protoc-gen-go \
  github.com/golang/dep/cmd/dep \
  github.com/haya14busa/goverage \
  github.com/constabulary/gb/... \
  github.com/dgrijalva/jwt-go/cmd/jwt \
  && gometalinter --install \
  && pip install --disable-pip-version-check --no-cache-dir azure-cli==${AZCLI_VERSION} \
  && apt-get purge --auto-remove -y libffi-dev python-dev python-pip

WORKDIR /go

COPY . /
