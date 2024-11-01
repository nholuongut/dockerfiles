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

ARG TCOLLECTOR_VERSION=1.3.2

LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

ENV PATH $PATH:/tcollector:/usr/local/tcollector

WORKDIR /

RUN \
    yum install -y python && \
    #yum install -y git && \
    #git clone https://github.com/OpenTSDB/tcollector /tcollector && \
    yum install -y \
        "https://github.com/OpenTSDB/tcollector/releases/download/v${TCOLLECTOR_VERSION}RC2/tcollector-${TCOLLECTOR_VERSION}-2.noarch.rpm" \
        "https://github.com/OpenTSDB/tcollector/releases/download/v${TCOLLECTOR_VERSION}RC2/tcollector-collectors-${TCOLLECTOR_VERSION}-2.noarch.rpm" \
        && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum

# RPM
ENV TCOLLECTOR_HOME="/usr/local/tcollector"
# GIT
#ENV TCOLLECTOR_HOME="/tcollector"

# RPM
CMD ["/usr/local/tcollector/tcollector.py", "-H", "opentsdb", "-c", "/usr/local/tcollector/collectors", "--logfile", "/dev/stdout", "--pidfile", "/tmp/tcollector.pid"]

# GIT
#CMD ["/tcollector/tcollector.py", "-H", "opentsdb", "-c", "/tcollector/collectors", "--logfile", "/dev/stdout", "--pidfile", "/tmp/tcollector.pid"]
