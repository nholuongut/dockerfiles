#
#  vim:ts=4:sts=4:sw=4:et
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

#FROM golang:alpine AS builder
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM golang:stretch AS builder

WORKDIR /

# awless standard build fetch is broken due to expired SSL cert:
#
#   https://github.com/wallix/awless/issues/278
#
#RUN apt-get update && apt-get install -y curl && \
#RUN #apk add --no-cache bash && \
    #curl https://raw.githubusercontent.com/wallix/awless/master/getawless.sh | sh && \
    #
    # or could download and modify the script
    #wget https://raw.githubusercontent.com/wallix/awless/master/getawless.sh && \
    #...
    #./getawless.sh
    #...
    #chmod +x getawless.sh && \
#   #apt-get purge -y curl && apt-get autoremove -y && apt-get clean -y

# just build straight from source instead

# musl-dev vs libc-dev results in the same size binary
#RUN apk add --no-cache git gcc musl-dev && \
#    go get -ldflags "-linkmode external -extldflags -static" -u github.com/wallix/awless

RUN go get -ldflags "-linkmode external -extldflags -static" -u github.com/wallix/awless

# ============

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM scratch
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

COPY --from=builder /go/bin/awless /awless

ENTRYPOINT ["/awless"]
