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
# ============================================================================ #
#                                   T F e n v
# ============================================================================ #

# https://github.com/tfutils/tfenv

# Loads the Terraform version dynamically at runtime
#
# pass TFENV_TERRAFORM_VERSION when running the container, otherwise will default to downloading the latest version of Terraform

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.12

LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

SHELL ["/bin/sh", "-eux", "-c"]

ENV OWNER_REPO="tfutils/tfenv"

# entrypoint.sh will override this is TERRAFORM_VERSION is set
ENV TFENV_TERRAFORM_VERSION=latest

ENV TFENV_AUTO_INSTALL=true

ENV USER=tfenv

ENV PATH "/home/$USER/.tfenv/bin:$PATH"

# git  - needed to clone tfenv
# curl - needed for tfenv to list and install versions
RUN apk add --no-cache \
    bash \
    git \
    curl

RUN adduser -D "$USER"

USER "$USER"

# bust cache from here on any new commits
ADD https://api.github.com/repos/$OWNER_REPO/git/refs/heads/master /.git-hashref

RUN git clone https://github.com/$OWNER_REPO.git ~/.tfenv

# do at runtime
#RUN tfenv install

COPY entrypoint.sh /

SHELL ["/bin/bash"]

# 'terraform' is wrapped by tfenv and will automatically install the right version before running the command
ENTRYPOINT ["/entrypoint.sh"]
