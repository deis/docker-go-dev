FROM golang:1.5.1

ENV GO15VENDOREXPERIMENT=1
ENV GLIDE_HOME=/root

WORKDIR /tmp

RUN wget https://github.com/Masterminds/glide/releases/download/0.7.2/glide-0.8.0-linux-amd64.tar.gz && \
    tar xvfz glide-0.8.0-linux-amd64.tar.gz && \
    mv linux-amd64/glide /usr/local/bin/ && \
    rm -rf linux-amd64 glide-0.8.0-linux-amd64.tar.gz

RUN go get -u -v github.com/golang/lint/golint

WORKDIR /go

COPY . /
