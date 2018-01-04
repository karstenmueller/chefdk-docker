FROM ubuntu:16.04
MAINTAINER karstenmueller

ARG CHANNEL=stable
ARG VERSION=2.4.17
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/chefdk/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && \
    apt-get install -y wget ssh git build-essential && \
    wget "http://packages.chef.io/files/${CHANNEL}/chefdk/${VERSION}/ubuntu/16.04/chefdk_${VERSION}-1_amd64.deb" -O /tmp/chefdk.deb && \
    dpkg -i /tmp/chefdk.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
