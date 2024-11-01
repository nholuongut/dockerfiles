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

# cache the std packages between tagged versions for space efficiency, must have this above ARG

# bash   => entrypoint.sh
# java   => presto engine
# python => launcher script
# less   => presto pager
# curl   => ./get_presto_version.sh
RUN set -eux && \
    apk add --no-cache bash openjdk8-jre-base python less

ARG PRESTO_VERSION="latest"
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"


WORKDIR /

ENV PATH $PATH:/presto/bin

COPY get_presto_versions.sh /

# hadolint ignore=DL4006
RUN set -eux && \
    TAR="presto-server-${PRESTO_VERSION}.tar.gz" && \
    apk add --no-cache curl wget tar && \
    if [ "$PRESTO_VERSION" = "latest" ]; then \
        # determine latest version automatically - this will be used by DockerHub automated builds but if calling Make it will pre-populate PRESTO_VERSION as part of make build to know the image to push
        PRESTO_VERSION=$(./get_presto_versions.sh | head -n1); \
    fi && \
    server_url="https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz" && \
    cli_url="https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar" && \
    wget -t 10 --retry-connrefused -O "${TAR}" "$server_url" && \
    test -s "${TAR}" && \
    tar zxf "${TAR}" && \
    # check tarball was extracted to the right place, helps ensure it's the right version and the link will work
    test -d "presto-server-${PRESTO_VERSION}" && \
    rm -fv  "${TAR}" && \
    ln -sv "presto-server-${PRESTO_VERSION}" presto && \
    wget -t 10 --retry-connrefused "$cli_url" && \
    test -s "presto-cli-${PRESTO_VERSION}-executable.jar" && \
    chmod +x "presto-cli-${PRESTO_VERSION}-executable.jar" && \
    mv -v "presto-cli-${PRESTO_VERSION}-executable.jar" presto/bin/ && \
    ln -sv "presto-cli-${PRESTO_VERSION}-executable.jar" presto/bin/presto && \
    rm -v get_presto_versions.sh && \
    apk del curl tar wget

# Add user support not running as root
RUN set -eux && \
    adduser -D presto && \
    mkdir -pv /presto/logs /var/lib/presto && \
    chown -R presto /presto/logs /var/lib/presto

COPY entrypoint.sh /
COPY etc /presto/etc

EXPOSE 8080

CMD ["/entrypoint.sh"]
