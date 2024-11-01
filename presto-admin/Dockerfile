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
FROM centos:7

ARG PRESTO_ADMIN_VERSION=2.3
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"


ARG TAR="prestoadmin-${PRESTO_ADMIN_VERSION}-online.tar.gz"

ENV PATH $PATH:/prestoadmin/bin

WORKDIR /

# bash   => entrypoint.sh
# java   => presto engine
# python => presto admin
RUN set -eux && \
    #yum install -y bash java-1.8.0-openjdk-headless python
    # pycrypto # resolves to python2-crypto
    yum install -y bash python && \
    yum clean all && \
    rm -rf /var/cache/yum

# hadolint ignore=DL3003
RUN set -eux && \
    yum install -y gcc python-devel tar wget && \
    url="https://github.com/prestodb/presto-admin/releases/download/$PRESTO_ADMIN_VERSION/$TAR" && \
    wget -t 10 --retry-connrefused -O "${TAR}" "$url" && \
    test -s "${TAR}" && \
    tar zxf "${TAR}" && \
    ls -l && \
    rm -fv  "${TAR}" && \
    cd prestoadmin && \
    ./install-prestoadmin.sh && \
    # trying to remove tar tries to remove systemd
    yum remove -y gcc python-devel wget && \
    yum autoremove -y && \
    rm -rf /var/cache/yum

#EXPOSE 8080

#CMD /entrypoint.sh
