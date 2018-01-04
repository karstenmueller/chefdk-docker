FROM ubuntu:16.04

ARG CHANNEL=stable
ARG VERSION=2.4.17
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/chefdk/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update
RUN apt-get install -y wget ssh git build-essential
RUN wget --quiet "http://packages.chef.io/files/${CHANNEL}/chefdk/${VERSION}/ubuntu/16.04/chefdk_${VERSION}-1_amd64.deb" -O /tmp/chefdk.deb && \
    dpkg -i /tmp/chefdk.deb
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" \
    | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 || true
RUN apt-get --quiet install apt-transport-https && \
    apt-get --quiet update && apt-get install azure-cli
RUN apt-get --quiet clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
