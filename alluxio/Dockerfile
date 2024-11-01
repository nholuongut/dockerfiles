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
ARG ALLUXIO_VERSION=1.8.1

ENV PATH $PATH:/alluxio/bin
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

WORKDIR /

SHELL ["/bin/sh", "-eux", "-c"]

# OpenJDK8 recent versions give error:
#
# org.apache.jasper.JasperException: PWC6033: Error in Javac compilation for JSP PWC6199: Generated servlet error: The type java.io.ObjectInputStream cannot be resolved. It is indirectly referenced from required .class files
#
# use OpenJDK7 instead
#
# needs a full JDK now for master, not just JRE
RUN apk add --no-cache bash openjdk8 sudo

RUN apk add --no-cache wget tar && \
    wget -t 100 --retry-connrefused -O "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" "http://alluxio.org/downloads/files/${ALLUXIO_VERSION}/alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    tar zxf "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    rm -fv "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    ln -sv "alluxio-${ALLUXIO_VERSION}" alluxio && \
    cp -v alluxio/conf/alluxio-env.sh.template alluxio/conf/alluxio-env.sh && \
    alluxio format && \
    apk del wget tar

COPY conf/alluxio-site.properties alluxio/conf/
COPY entrypoint.sh /

EXPOSE 19999 30000

ENTRYPOINT ["/entrypoint.sh"]
