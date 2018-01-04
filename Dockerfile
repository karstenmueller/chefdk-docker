FROM ubuntu:16.04
MAINTAINER karstenmueller

ARG CHANNEL=stable
ARG VERSION=2.4.17
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/chefdk/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && \
    apt-get install -y wget ssh git build-essential \
    wget --content-disposition "http://packages.chef.io/files/${CHANNEL}/chefdk/${VERSION}/ubuntu/16.04/chefdk_${VERSION}-1_amd64.deb" -O /tmp/chefdk.deb && \
    dpkg -i /tmp/chefdk.deb \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 && \
    apt-get install apt-transport-https && \
    apt-get update && sudo apt-get install azure-cli \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
