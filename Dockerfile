FROM alpine:3.2
MAINTAINER Calvin Leung Huang <cleung2010@gmail.com>

ENV CONSUL_VERSION 0.6.3
ENV CONSUL_SHA256 b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250

# Download binaries
ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip /tmp/consul.zip
ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip /tmp/consul_ui.zip

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

ENTRYPOINT ["consul"]
