FROM alpine:3.2
MAINTAINER Calvin Leung Huang <cleung2010@gmail.com>

ENV CONSUL_VERSION 0.5.2
ENV CONSUL_SHA256 171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445

RUN apk --update add curl ca-certificates

# Need to install glibc on alpine to run Consul
RUN curl -Ls https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk > /tmp/glibc-2.21-r2.apk && \
    apk add --allow-untrusted /tmp/glibc-2.21-r2.apk && \
    rm -rf /tmp/glibc-2.21-r2.apk /var/cache/apk/*

# Download binaries
ADD https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_linux_amd64.zip /tmp/consul.zip
ADD https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_web_ui.zip /tmp/consul_ui.zip

# Create the common directories for Consul
RUN mkdir -p /opt/consul && \
    mkdir -p /etc/consul.d && \
    mkdir -p /ui

# Install Consul and its UI
RUN echo "${CONSUL_SHA256}  /tmp/consul.zip" > /tmp/consul.sha256 && \
    sha256sum -c /tmp/consul.sha256 && \
    unzip /tmp/consul.zip -d /usr/local/bin && \
    unzip /tmp/consul_ui.zip -d /ui && \
    rm /tmp/consul.zip /tmp/consul_ui.zip

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

ENTRYPOINT ["consul", "agent"]
