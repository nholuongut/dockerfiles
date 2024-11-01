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
FROM ubuntu:20.04

ARG GITHUB_ACTIONS_RUNNER_VERSION=2.284.0
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

ENV PATH $PATH:/actions-runner

ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# creates and cd's to this dir
WORKDIR /actions-runner

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl sudo && \
    curl -Lo actions-runner.tar.gz "https://github.com/actions/runner/releases/download/v$GITHUB_ACTIONS_RUNNER_VERSION/actions-runner-linux-x64-$GITHUB_ACTIONS_RUNNER_VERSION.tar.gz" && \
    tar zxvf actions-runner.tar.gz && \
    rm -f actions-runner.tar.gz && \
    useradd actions-runner && \
    echo "actions-runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    bin/installdependencies.sh && \
    chown -R actions-runner /actions-runner && \
    curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/bin/clean_caches.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# adds nearly 500MB to the image size
#run apt-get update && \
#    apt-get install -y docker.io && \
#    curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/bin/clean_caches.sh | sh

SHELL ["/bin/bash"]

USER actions-runner

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
