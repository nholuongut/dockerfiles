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
FROM alpine:3.12
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

ENV PATH $PATH:/home/aws/.local/bin

SHELL ["/bin/sh", "-eux", "-c"]

# needs Python, Rust, Cargo, Make and various headers and libs to build EB CLI
RUN apk add --no-cache \
    bash \
    cargo \
    gcc \
    libc-dev \
    libffi-dev \
    libressl-dev \
    make \
    py3-pip \
    python3 \
    python3-dev \
    rust
    #linux-headers

RUN adduser -D aws

USER aws

RUN python3 -m pip install \
        --user \
        'urllib3>=1.26.5' \
        awsebcli && \
    echo && \
    echo "Checking EB CLI runtime..." && \
    echo && \
    eb --help --quiet
        #pip \
        #--upgrade \
        #--ignore-installed \
        #urllib3 \

SHELL ["/bin/bash"]

ENTRYPOINT ["eb"]
