FROM golang:1.5.1

ENV GO15VENDOREXPERIMENT=1
ENV GLIDE_HOME=/root

WORKDIR /tmp

RUN wget https://github.com/Masterminds/glide/releases/download/0.7.2/glide-0.7.2-linux-amd64.tar.gz

RUN tar xvfz glide-0.7.2-linux-amd64.tar.gz

RUN mv linux-amd64/glide /usr/local/bin/

RUN rm -rf linux-amd64 glide-0.7.2-linux-amd64.tar.gz

WORKDIR /go

COPY . /
