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
FROM centos:8

ARG SUPERSET_VERSION=0.30.1
ARG AVATICA_VERSION=1.17.0
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

WORKDIR /

# Apache Calcite's Avatica JDBC driver for connecting to Druid
RUN mkdir -pv /home/avatica/classpath
ADD https://repository.apache.org/content/groups/public/org/apache/calcite/avatica/avatica-noop-driver/${AVATICA_VERSION}/avatica-noop-driver-${AVATICA_VERSION}.jar /home/avatica/classpath

ENV CLASSPATH=/home/avatica/classpath

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# Java needed for Apache Calcite's Avatica driver
# hadolint ignore=DL3013
RUN yum install -y epel-release && \
    yum install -y \
        java-headless && \
        gcc \
        gcc-c++ \
        libffi-devel \
        python3-devel \
        python3-pip \
        python3-wheel \
        openssl-devel \
        cyrus-sasl-devel \
        openldap-devel \
        mysql-devel && \
    alternatives --set python /usr/bin/python3 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip3 100 && \
    # 0.30.1 needs tonnes of Python dependencies when booting superset that are not automatically pulled in, found by iterative testing :-/
    pip install mysqlclient \
                pyhive \
                backoff \
                contextlib2 \
                croniter \
                cryptography \
                flask \
                flask-appbuilder \
                flask-caching \
                flask-compress \
                flask-migrate \
                flask-talisman \
                bleach \
                celery \
                humanize \
                python-geohash \
                geopy \
                isodate \
                markdown \
                msgpack \
                numpy \
                pandas \
                parsedatetime \
                pathlib2 \
                polyline \
                pyarrow \
                retry \
                selenium \
                sqlparse \
                simplejson \
                wtforms-json && \
    # built on Superset 0.19 originally, update tested on 0.30.1
    pip install superset && \
    printf 'admin\nadmin\nuser\nroot@localhost\nadmin\nadmin\n' | \
    superset fab create-admin && \
    superset db upgrade && \
    superset load-examples && \
    superset init && \
    yum remove -y \
        gcc \
        gcc-c++ \
        libffi-devel \
        python-devel \
        openssl-devel \
        cyrus-sasl-devel \
        openldap-devel \
        mysql-devel && \
    yum autoremove -y && \
    curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/bin/clean_caches.sh | sh && \
    yum clean all && \
    rm -rf /var/cache/yum

EXPOSE 8088

SHELL ["/bin/bash"]

# hadolint ignore=DL3025
CMD /usr/local/bin/superset run -h 0.0.0.0 -p 8088
