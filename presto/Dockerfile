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
FROM centos:7

# cache the std packages between tagged versions for space efficiency, must have this above ARG

# bash   => entrypoint.sh
# java   => presto engine
# python => launcher script
# less   => presto pager
RUN set -eux && \
    yum install -y bash java-1.8.0-openjdk-headless.x86_64 python less && \
    yum clean all

WORKDIR /

ARG PRESTO_VERSION=0.179
ARG PRESTO_PKG_RELEASE=0.1

LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"


# for faster build testing without having to download
#COPY $TAR /
#COPY $CLI_TAR /

RUN set -eux && \
    # not doing these as ARG above as that doesn't catch imperfections in the re-use of env vars via set -u
    TAR="presto_server_pkg.${PRESTO_VERSION}-t.${PRESTO_PKG_RELEASE}.tar.gz" && \
    # server package contains CLI but we need CLI package for ODBC + JDBC drivers
    CLI_TAR="presto_client_pkg.${PRESTO_VERSION}-t.${PRESTO_PKG_RELEASE}.tar.gz" && \
    SERVER_RPM="presto-server-rpm-${PRESTO_VERSION}-t.${PRESTO_PKG_RELEASE}.x86_64.rpm" && \
    SERVER_TAR_DIR="presto_server_pkg.${PRESTO_VERSION}-t.${PRESTO_PKG_RELEASE}" && \
    CLI_TAR_DIR="presto_client_pkg.${PRESTO_VERSION}-t.${PRESTO_PKG_RELEASE}" && \
    CLI_JAR="presto-cli-${PRESTO_VERSION}-t.${PRESTO_PKG_RELEASE}-executable.jar" && \
    SERVER_URL="http://teradata-presto.s3.amazonaws.com/release-packages/${PRESTO_VERSION}-t.${PRESTO_PKG_RELEASE}/$TAR" && \
    CLI_URL="http://teradata-presto.s3.amazonaws.com/release-packages/${PRESTO_VERSION}-t.${PRESTO_PKG_RELEASE}/$CLI_TAR" && \
    yum install -y wget tar && \
    wget -c -t 10 --retry-connrefused -O "$TAR" "$SERVER_URL" && \
    wget -c -t 10 --retry-connrefused -O "$CLI_TAR" "$CLI_URL" && \
    tar zxvf "$TAR" && \
    #yum localinstall -y "$SERVER_TAR_DIR/$SERVER_RPM" && \
    # complains about java version
    rpm -ivh --noscripts "$SERVER_TAR_DIR/$SERVER_RPM" && \
    rm -rfv  "$TAR" "$SERVER_TAR_DIR" && \
    tar zxvf "$CLI_TAR" && \
    mv -iv "$CLI_TAR_DIR/$CLI_JAR" . && \
    chmod +x "$CLI_JAR" && \
    ln -sv "/$CLI_JAR" /usr/bin/presto && \
    # the JDBC 4.2 driver is the one for Java 8
    mv -iv "$CLI_TAR_DIR"/jdbc/presto-jdbc42-*.jar . && \
    yum localinstall -y "$CLI_TAR_DIR"/odbc/TeradatPrestoODBC-64-bit-*.rpm && \
    # get rid of all the other unneeded drivers to save space
    rm -fr "$CLI_TAR" "$CLI_TAR_DIR" && \
    # older versions of Presto look for config in /usr/lib/presto/etc, linking for compatability across versions
    ln -sv /etc/presto /usr/lib/presto/etc && \
    yum remove -y wget && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum

# Add user support not running as root
RUN set -eux && \
    mkdir -vp /var/lib/presto /var/log/presto && \
    useradd presto && \
    chown -R presto /etc/presto /usr/lib/presto /var/lib/presto /var/log/presto

COPY entrypoint.sh /
COPY etc /etc/presto/

EXPOSE 8080

CMD ["/entrypoint.sh"]
