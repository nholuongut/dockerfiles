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
FROM jetbrains/teamcity-server:2020.2

# used to version tagging by Make build, keep aligned with the FROM above since it can't be used in the FROM directly
ARG TEAMCITY_VERSION=2020.2

ARG MYSQL_CONNECTOR_VERSION=8.0.22
ARG POSTGRESQL_CONNECTOR_VERSION=42.2.18

LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

# XXX: this directory gets replaced / covered over, this build isn't necessary any more
ENV JDBCDIR=/data/teamcity_server/datadir/lib/jdbc/

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

WORKDIR ${JDBCDIR}

RUN curl -sSL "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz" | \
    tar zxvf - --strip 1 "mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar" && \
    ln -sfv "mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar" "mysql-connector-java.jar"

RUN curl -sS "https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_CONNECTOR_VERSION}.jar" > "postgresql-${POSTGRESQL_CONNECTOR_VERSION}.jar" && \
    ln -sfv "postgresql-${POSTGRESQL_CONNECTOR_VERSION}.jar" "postgresql.jar"

WORKDIR /
