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
FROM debian:11 as builder
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/go-tools/bin

ADD https://raw.githubusercontent.com/nholuongut/DevOps-Bash-tools/master/setup/docker_bootstrap.sh /build.sh

RUN chmod +x /build.sh && NO_TESTS=1 /build.sh

# gets error:
# bash: ./uniq2: No such file or directory
#FROM bash
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM debian:11

ENV PATH $PATH:/github/go-tools/bin

COPY --from=builder /github/go-tools/bin/colors     /github/go-tools/bin/
COPY --from=builder /github/go-tools/bin/httpfirst  /github/go-tools/bin/
COPY --from=builder /github/go-tools/bin/uniq2      /github/go-tools/bin/
COPY --from=builder /github/go-tools/bin/welcome    /github/go-tools/bin/

CMD ["/bin/bash", "-c", "find /github/go-tools/bin -maxdepth 1 -type f | xargs -n1 basename | sort"]
