FROM centos:centos7

MAINTAINER Jayson Ge <gyj3023@foxmail.com>

ENV KEEPALIVED_VERSION=1.2.19

RUN yum update -y && \
    yum install -y libnl libnl-devel libssl-dev openssl libpopt-dev make gcc daemon wget openssl-devel && \
    wget http://www.keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz && \
    tar -zxvf keepalived-${KEEPALIVED_VERSION}.tar.gz && \
    cd keepalived-${KEEPALIVED_VERSION}/ && \
    ./configure --prefix=/ && \
    make && make install && \
    mkdir -p /var/lock/subsys

ENV KEEPALIVED_OPTIONS=${KEEPALIVED_OPTIONS}

RUN sed -i "s:. /etc/sysconfig/keepalived:. /etc/keepalived:"  /etc/init.d/keepalived && \
    sed -i "s:daemon keepalived ${KEEPALIVED_OPTIONS}:daemon keepalived start:"  /etc/init.d/keepalived

COPY ./templates/keepalived_template.cfg  /etc/keepalived/
COPY ./keepalived  /
RUN  /keepalived

CMD ["service", "keepalived", "start"] 
