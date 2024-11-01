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
# running kustomize command breaks horribly on 'kustomize edit', even 'kustomize version' hangs - even with gcompat - probaby due to musl vs libc
#FROM alpine/git:v2.32.0
#FROM ubuntu:20.04
# a little smaller image
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM debian:10-slim

LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"


ENV DEBIAN_FRONTEND noninteractive

ARG KUSTOMIZE_VERSION=4.4.1
ARG GIT_KUSTOMIZE_VERSION=4.4.1  # workaround for hooks/post_build

WORKDIR /

RUN bash -c 'set -euxo pipefail && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl git openssh-client && \
    curl -Lo /tmp/kustomize.tgz "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
    tar zxvf /tmp/kustomize.tgz kustomize -O > /usr/local/bin/kustomize && \
    rm -v /tmp/kustomize.tgz && \
    chmod -v +x /usr/local/bin/kustomize && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists && \
    git version && \
    kustomize version'  # check kustomize executes ok

ENTRYPOINT ["/bin/bash"]
