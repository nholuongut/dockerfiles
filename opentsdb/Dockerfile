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
FROM nholuongut/centos-java:jdk8
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"
   org.opencontainers.image.source="https://github.com/nholuongut/Dockerfiles"

WORKDIR /

RUN \
    yum install -y "https://github.com/OpenTSDB/opentsdb/releases/download/v${OPENTSDB_VERSION}/opentsdb-${OPENTSDB_VERSION}.noarch.rpm" && \
    yum autoremove -y && \
    mkdir -pv /etc/hbase/conf && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY hbase-site.xml /etc/hbase/conf/
COPY entrypoint.sh /
COPY opentsdb.conf /etc/opentsdb/

EXPOSE 4242

CMD ["/entrypoint.sh"]
