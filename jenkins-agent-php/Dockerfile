#
#  Author: Nho Luong
#  Date: 2020-03-13 21:10:39 +0000 (Fri, 13 Mar 2020)
#
#  vim:ts=2:sts=2:sw=2:et
#
#  https://github.com/nholuongut/dockerfiles
#
#  License: see accompanying Nho Luong LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM jenkins/inbound-agent:latest-bookworm

ARG JENKINS_AGENT_VERSION=latest-bookworm

LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"


SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

USER root

ENV DEBIAN_FRONTEND noninteractive

# XXX: these aren't packaged and take a long time to build so don't change this or anything above this to keep this cached
#        php-grpc \
#        php-pecl-couchbase4.x86_64 \
#        php-pecl-zstd && \
RUN apt-get update -y && \
    apt-get install -y \
        autoconf \
        php-dev \
        php-pear \
        zlib1g-dev && \
    pecl install \
        couchbase-4 \
        grpc \
        zstd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -y && \
    apt-get install -y \
        ca-certificates \
        curl \
        git \
        gnupg \
        nano \
        openssh-client \
        unzip \
        wget \
        zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#RUN dnf install -y dnf-utils https://rpms.remirepo.net/enterprise/remi-release-8.rpm && \
#    dnf update -y && \
#    dnf module enable php:remi-8.1 -y && \
#    dnf --enablerepo=remi install php-amqplib -y && \
#    dnf install php-pecl-xdebug -y

#RUN rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm

RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list && \
    curl https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    apt-get update && \
    apt-get -y install newrelic-php5 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -y && \
    apt-get install -y \
        php-apcu \
        php-amqp \
        php-bcmath \
        php-cli \
        php-fpm php-dev \
        php-gd \
        php-google-protobuf \
        php-imagick \
        php-intl \
        php-mbstring \
        php-mcrypt php-xml \
        php-memcache \
        php-memcached \
        php-mongodb \
        php-mysqli \
        php-mysqlnd \
        php-opcache \
        php-pdo \
        php-pear \
        php-pgsql \
        php-redis \
        php-solr \
        php-tidy \
        php-yaml \
        php-zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd nginx && \
    usermod -m -d /home/nginx -s /bin/false nginx && \
    usermod -u 497 nginx && \
    groupmod -g 496 nginx && \
    mkdir -pv /run/php-fpm && \
    mkdir -pv /var/lib/php/session && \
    chown nginx:nginx /run/php-fpm && \
    chown nginx:nginx /var/lib/php/session

# COPY php-fpm.conf /etc/php-fpm.conf
# COPY php.ini /etc/php.ini
# COPY www.conf /etc/php-fpm.d/www.conf

SHELL ["/bin/bash"]

USER jenkins
