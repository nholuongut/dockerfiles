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

ENV PATH $PATH:/github/spotify-tools:/github/spotify-tools/bash-tools

RUN mkdir -v /github

WORKDIR /github

# hadolint ignore=DL3003
RUN set -eux && \
    x=spotify-tools; \
    apk add --no-cache make git && \
    git clone https://github.com/nholuongut/$x /github/$x && \
    cd /github/$x && \
    make build clean && \
    make apk-packages-remove && \
    apk del make git

WORKDIR /github/spotify-tools

# trying to do -exec basename {} \; results in only the jython files being printed
# hadolint ignore=DL3025
CMD find /github/spotify-tools -maxdepth 2 -type f -name '*.pl' -o -type f -name '*.sh' | grep spotify | grep -v old/ | xargs -n1 basename | sort
