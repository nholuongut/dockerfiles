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
FROM nholuongut/debian-java:jre7

ARG MESOS_VERSION=0.28.2
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"


#ARG TAR="mesos-$MESOS_VERSION.tar.gz"

ENV DEBIAN_FRONTEND noninteractive

ENV PATH $PATH:/mesos/bin

WORKDIR /

# debian uses sh -c by default which doesn't recognize the ${var:n:n}
RUN bash -c '\
    set -euxo pipefail && \
    apt-get update && \
    # need net-tools for ifconfig in /entrypoint.sh
    apt-get install -y --no-install-recommends wget net-tools && \
    # Apache only ships source, don't want entire dev tooling in image
    #apt-get install -y --no-install-recommends tar wget && \
    #wget -t 10 --retry-connrefused "http://archive.apache.org/dist/mesos/$MESOS_VERSION/$TAR" && \
    #tar zxvf "$TAR" && \
    #rm -v "$TAR" && \
    #ln -sf "mesos-$MESOS_VERSION" mesos && \
    #
    # doesn't take past release version suffixes and repo is non-browseable (MESOS-5608)
#    apt-get install -y --no-install-recommends lsb-release && \
#    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
#    DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') && \
#    CODENAME=$(lsb_release -cs) && \
#    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | tee /etc/apt/sources.list.d/mesosphere.list && \
#    apt-get update && \
#
    if   [ "${MESOS_VERSION:0:4}" = "0.23" ]; then file="mesos_$MESOS_VERSION-1.0.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.24" ]; then file="mesos_$MESOS_VERSION-2.0.17.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.25" ]; then file="mesos_$MESOS_VERSION-2.0.21.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.26" ]; then file="mesos_$MESOS_VERSION-2.0.19.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.27" ]; then file="mesos_$MESOS_VERSION-2.0.15.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.28" ]; then file="mesos_$MESOS_VERSION-2.0.27.debian81_amd64.deb"; \
    else echo "unexpected mesos version"; exit 1; fi && \
    wget -t 10 --retry-connrefused "http://repos.mesosphere.com/debian/pool/main/m/mesos/$file" && \
    #apt-get install ./mesos*.deb && \
    dpkg -i mesos*.deb || :; \
    apt-get install -yf && \
    dpkg -i mesos*.deb && \
    # attempting to remove tar causes unmet dependency breakage
    apt-get purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean'

COPY entrypoint.sh /

EXPOSE 5050 5051

ENTRYPOINT ["/entrypoint.sh"]
