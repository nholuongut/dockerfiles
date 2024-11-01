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
FROM alpine:3.12
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

ENV PATH $PATH:/github/nagios-plugin-kafka

RUN mkdir -v /github

WORKDIR /github

# bash => test scripts
# java => kafka
RUN set -eux && \
    apk add --no-cache bash openjdk8

# hadolint ignore=DL3003
RUN set -eux && \
    apk add --no-cache git make alpine-sdk && \
    x=nagios-plugin-kafka; \
    git clone https://github.com/nholuongut/$x /github/$x && \
    cd /github/$x && \
    make build test && \
    # not using mv as it's as symlink, cp will take the target
    cp -i check_kafka.jar check_kafka.jar2 && \
    # clean removes the link along with the target/build dir
    make deep-clean && \
    mv -i check_kafka.jar2 check_kafka.jar && \
    apk del git make alpine-sdk

WORKDIR /github/nagios-plugin-kafka

CMD ["./check_kafka", "--help"]
