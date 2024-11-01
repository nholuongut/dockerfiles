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

# can't base off official Riak as it's missing deps to run the tools
#FROM riak
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM centos:8

ARG RIAK_VERSION=2.1.4
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

#RUN OS=el DIST=6 curl "https://packagecloud.io/install/repositories/basho/riak/config_file.repo?os=${OS}&dist=${DIST}&name=basho_repo" > /etc/yum.repos.d/basho.repo && \

# Riak 1.x
#RUN set -euxo pipefail && \
#    yum install -y http://yum.basho.com/gpg/basho-release-6-1.noarch.rpm && \
#    yum install -y riak-$RIAK_VERSION && \
#    yum autoremove -y && \
#    yum clean all
# Riak 2.x
RUN bash -c ' \
    set -euxo pipefail && \
    yum install -y "http://s3.amazonaws.com/downloads.basho.com/riak/$(sed 's/.[[:digit:]]*$//' <<< "$RIAK_VERSION")/$RIAK_VERSION/rhel/6/riak-$RIAK_VERSION-1.el6.x86_64.rpm" && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum \
    '

# make HTTP listen on 0.0.0.0 not 127.0.0.1
# Riak 1.x
#COPY conf/app.config /etc/riak/
# Riak 2.x
COPY conf/riak.conf /etc/riak/

EXPOSE 8087 8098

# hadolint ignore=DL3025
CMD su - riak -c '/usr/sbin/riak start'; sleep 5; cat /var/log/riak/*; tail -f /dev/null /var/log/riak/*
