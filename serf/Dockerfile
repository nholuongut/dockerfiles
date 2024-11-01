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
# busybox wget doesn't support SSL, no curl available :-(
#FROM busybox:latest
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.12

ARG SERF_VERSION=0.8.2

LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

ENV PATH $PATH:/

#COPY serf /

#ADD https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip /

WORKDIR /

RUN set -eux && \
    apk add --no-cache wget unzip ca-certificates && \
    wget -t 100 --retry-connrefused -O "serf_${SERF_VERSION}_linux_amd64.zip" "https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip" && \
    unzip "serf_${SERF_VERSION}_linux_amd64.zip" && \
    rm -fv "serf_${SERF_VERSION}_linux_amd64.zip" && \
    apk del wget unzip ca-certificates

EXPOSE 7946 7373

#COPY entrypoint.sh /

ENTRYPOINT ["/serf"]
#ENTRYPOINT ["/entrypoint.sh"]
