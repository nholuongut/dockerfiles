#
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
FROM nholuongut/alpine-java:latest
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

#ENV GRADLE_HOME=/opt/gradle
ENV GROOVY_HOME=/opt/groovy
ENV JYTHON_HOME=/opt/jython
#ENV MAVEN_HOME=/opt/maven
ENV SBT_HOME=/opt/sbt

ENV PATH $PATH:$GRADLE_HOME/bin:$GROOVY_HOME/bin:$JYTHON_HOME/bin:$MAVEN_HOME/bin:$SBT_HOME/bin

SHELL ["/bin/sh", "-eux"]

RUN mkdir -p /opt && \
    apk add --no-cache \
        acf-openssl \
        alpine-sdk \
        bash \
        bind-tools \
        curl \
        cyrus-sasl-dev \
        expat-dev \
        expect \
        ethtool \
        fping \
        gcc \
        git \
        go \
        gradle \
        grep \
        jwhois \
        libev \
        libevdev \
        libressl-dev \
        lsof \
        make \
        mariadb-dev \
        maven \
        netcat-openbsd \
        net-tools \
        nmap \
        nmap-ncat \
        perl \
        perl-dbd-mysql \
        perl-libwww \
        procps \
        py-pip \
        py-setuptools \
        python3-dev \
        py3-mysqlclient \
        ruby \
        ruby-dev \
        snappy-dev \
        socat \
        strace \
        sysstat \
        tar \
        tcpdump \
        unzip \
        vim \
        wget \
        which \
        zip

SHELL ["/bin/bash", "-euxo", "pipefail"]

# didn't have Gradle / Groovy / Maven / SBT packages ...

WORKDIR /opt

# SBT
RUN curl https://raw.githubusercontent.com/nholuongut/bash-tools/master/install/install_sbt.sh | sh

WORKDIR /

# Groovy
RUN curl https://raw.githubusercontent.com/nholuongut/bash-tools/master/install/install_groovy.sh | sh

# Jython
# hadolint ignore=DL4001
RUN wget https://raw.githubusercontent.com/nholuongut/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/nholuongut/devops-python-tools/master/jython_autoinstall.exp && \
    sh jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp

SHELL ["/bin/bash"]

CMD ["/bin/bash"]
