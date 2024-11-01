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

# Alpine's underlying libraries are causing find_active_server.py --https mode to run all threads concurrently without respecting the --num causing indeterministic results and failing tests/test_find_active_server.sh
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.20
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"


#ENV JYTHON_HOME=/opt/jython
#ENV PATH $PATH:$JYTHON_HOME/bin:/github/devops-python-tools

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/pytools:/github/pytools/bash-tools

# access the scripts via the $PATH - safer than trying to do .profile injection since it may not be triggered
ENV PATH $PATH:/github/pytools/bash-tools/ai
ENV PATH $PATH:/github/pytools/bash-tools/appveyor
ENV PATH $PATH:/github/pytools/bash-tools/aws
ENV PATH $PATH:/github/pytools/bash-tools/azure_devops
ENV PATH $PATH:/github/pytools/bash-tools/bigdata
ENV PATH $PATH:/github/pytools/bash-tools/bin
ENV PATH $PATH:/github/pytools/bash-tools/bitbucket
ENV PATH $PATH:/github/pytools/bash-tools/buildkite
ENV PATH $PATH:/github/pytools/bash-tools/checks
ENV PATH $PATH:/github/pytools/bash-tools/cicd
ENV PATH $PATH:/github/pytools/bash-tools/circleci
ENV PATH $PATH:/github/pytools/bash-tools/cloudflare
ENV PATH $PATH:/github/pytools/bash-tools/data
ENV PATH $PATH:/github/pytools/bash-tools/docker
ENV PATH $PATH:/github/pytools/bash-tools/drone
ENV PATH $PATH:/github/pytools/bash-tools/gcp
ENV PATH $PATH:/github/pytools/bash-tools/git
ENV PATH $PATH:/github/pytools/bash-tools/github
ENV PATH $PATH:/github/pytools/bash-tools/gitlab
ENV PATH $PATH:/github/pytools/bash-tools/install
ENV PATH $PATH:/github/pytools/bash-tools/ipaas
ENV PATH $PATH:/github/pytools/bash-tools/java
ENV PATH $PATH:/github/pytools/bash-tools/jenkins
ENV PATH $PATH:/github/pytools/bash-tools/kafka
ENV PATH $PATH:/github/pytools/bash-tools/kubernetes
ENV PATH $PATH:/github/pytools/bash-tools/media
ENV PATH $PATH:/github/pytools/bash-tools/monitoring
ENV PATH $PATH:/github/pytools/bash-tools/mysql
ENV PATH $PATH:/github/pytools/bash-tools/packages
ENV PATH $PATH:/github/pytools/bash-tools/perl
ENV PATH $PATH:/github/pytools/bash-tools/pingdom
ENV PATH $PATH:/github/pytools/bash-tools/postgres
ENV PATH $PATH:/github/pytools/bash-tools/python
ENV PATH $PATH:/github/pytools/bash-tools/scripts
ENV PATH $PATH:/github/pytools/bash-tools/search
ENV PATH $PATH:/github/pytools/bash-tools/setup
ENV PATH $PATH:/github/pytools/bash-tools/spotify
ENV PATH $PATH:/github/pytools/bash-tools/terraform

ADD https://raw.githubusercontent.com/nholuongut/DevOps-Bash-tools/master/setup/docker_bootstrap.sh /build.sh

RUN chmod +x /build.sh && NO_TESTS=1 /build.sh
    # allows numpy to compile with musl instead of glibc
    #ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    #py-cffi && \

# Cache Bust upon new commits
ADD https://api.github.com/repos/nholuongut/DevOps-Python-tools/git/refs/heads/master /.git-hashref

ADD https://raw.githubusercontent.com/nholuongut/Dockerfiles/master/src/list_python_jython.sh /list.sh

# 2nd run is almost a noop without cache, and only an incremental update upon cache bust
RUN chmod +x /list.sh && /build.sh

# Jython
#
# Not realistically gonna use Hadoop Jython utils from docker when they need -Jcp `hadoop classpath` anyway, leave it for nholuongut/hadoop-dev docker image
#
#RUN set -euxo pipefail && \
#    yum install -y wget expect && \
#    wget https://raw.githubusercontent.com/nholuongut/devops-python-tools/master/jython_install.sh && \
#    wget https://raw.githubusercontent.com/nholuongut/devops-python-tools/master/jython_autoinstall.exp && \
#    bash jython_install.sh && \
#    yum remove -y wget expect && \
#    curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/bin/clean_caches.sh | sh
#    rm -f jython_install.sh jython_autoinstall.exp

#COPY profile.d/java.sh /etc/profile.d/

WORKDIR /github/pytools

CMD ["/list.sh", "/github/pytools"]
