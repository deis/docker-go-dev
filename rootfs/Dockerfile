FROM golang:1.6-alpine

ENV GO15VENDOREXPERIMENT=1
ENV GLIDE_HOME=/root

ADD https://github.com/lalyos/docker-upx/releases/download/v3.91/upx /usr/local/bin/upx
RUN chmod +x /usr/local/bin/upx \
    && apk -U add bzr git mercurial tar \
    && go get -u -v \
      github.com/golang/lint/golint \
      github.com/onsi/ginkgo/ginkgo \
      github.com/pwaller/goupx \
      github.com/mitchellh/gox \
    && curl -sSL https://github.com/Masterminds/glide/releases/download/0.9.3/glide-0.9.3-linux-amd64.tar.gz \
      | tar -vxz -C /usr/local/bin --strip=1
