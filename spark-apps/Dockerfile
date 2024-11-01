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
FROM nholuongut/centos-scala:2.11-jdk8
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"
org.opencontainers.image.source="https://github.com/nholuongut/Dockerfiles"

# unit test for lib-java fails when sh is found in /usr/bin/sh as /usr/bin is earlier in the path than /bin
ENV PATH /bin:$PATH:/github/spark-apps

RUN mkdir -vp /github

WORKDIR /github

# hadolint ignore=DL3003
RUN bash -c ' \
    set -euxo pipefail && \
    x=spark-apps; \
    yum install -y make git maven && \
    curl -L https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y --nogpgcheck sbt && \
    git clone https://github.com/nholuongut/$x /github/$x && \
    cd /github/$x && \
    make build clean && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum \
    '

WORKDIR /github/spark-apps

CMD ["/bin/bash"]
