FROM ubuntu:trusty

MAINTAINER Jayson Ge <gyj3023@foxmail.com>

ENV KEEPALIVED_VERSION=1.2.19

RUN apt-get update && \
    apt-get install -y libssl-dev openssl libpopt-dev make gcc daemon wget && \
    wget http://www.keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz && \
    tar -zxvf keepalived-${KEEPALIVED_VERSION}.tar.gz && \
    cd keepalived-${KEEPALIVED_VERSION}/ && \
    ./configure --prefix=/ && \
    make && make install && \
    cp /etc/rc.d/init.d/keepalived /etc/init.d && \
    mkdir -p /var/lock/subsys

ENV KEEPALIVED_OPTIONS=${KEEPALIVED_OPTIONS}

RUN sed -i "s:. /etc/rc.d/init.d/functions:. /lib/lsb/init-functions:"  /etc/init.d/keepalived && \
    sed -i "s:. /etc/sysconfig/keepalived:. /etc/keepalived:"  /etc/init.d/keepalived && \
    sed -i "s:daemon keepalived ${KEEPALIVED_OPTIONS}:daemon keepalived start:"  /etc/init.d/keepalived

COPY ./templates/keepalived_template.cfg  /etc/keepalived/
COPY ./scripts/master.sh /etc/keepalived/
COPY ./keepalived  /
RUN chmod +x /etc/keepalived/master.sh && \
    /keepalived


CMD ["service", "keepalived", "start"] 
