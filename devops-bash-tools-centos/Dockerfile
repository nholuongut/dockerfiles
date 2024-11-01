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
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/bash-tools

# access the scripts via the $PATH - safer than trying to do .profile injection since it may not be triggered
ENV PATH $PATH:/github/bash-tools/ai
ENV PATH $PATH:/github/bash-tools/appveyor
ENV PATH $PATH:/github/bash-tools/aws
ENV PATH $PATH:/github/bash-tools/azure_devops
ENV PATH $PATH:/github/bash-tools/bigdata
ENV PATH $PATH:/github/bash-tools/bin
ENV PATH $PATH:/github/bash-tools/bitbucket
ENV PATH $PATH:/github/bash-tools/buildkite
ENV PATH $PATH:/github/bash-tools/checks
ENV PATH $PATH:/github/bash-tools/cicd
ENV PATH $PATH:/github/bash-tools/circleci
ENV PATH $PATH:/github/bash-tools/cloudflare
ENV PATH $PATH:/github/bash-tools/data
ENV PATH $PATH:/github/bash-tools/docker
ENV PATH $PATH:/github/bash-tools/drone
ENV PATH $PATH:/github/bash-tools/gcp
ENV PATH $PATH:/github/bash-tools/git
ENV PATH $PATH:/github/bash-tools/github
ENV PATH $PATH:/github/bash-tools/gitlab
ENV PATH $PATH:/github/bash-tools/install
ENV PATH $PATH:/github/bash-tools/ipaas
ENV PATH $PATH:/github/bash-tools/java
ENV PATH $PATH:/github/bash-tools/jenkins
ENV PATH $PATH:/github/bash-tools/kafka
ENV PATH $PATH:/github/bash-tools/kubernetes
ENV PATH $PATH:/github/bash-tools/media
ENV PATH $PATH:/github/bash-tools/monitoring
ENV PATH $PATH:/github/bash-tools/mysql
ENV PATH $PATH:/github/bash-tools/packages
ENV PATH $PATH:/github/bash-tools/perl
ENV PATH $PATH:/github/bash-tools/pingdom
ENV PATH $PATH:/github/bash-tools/postgres
ENV PATH $PATH:/github/bash-tools/python
ENV PATH $PATH:/github/bash-tools/scripts
ENV PATH $PATH:/github/bash-tools/search
ENV PATH $PATH:/github/bash-tools/setup
ENV PATH $PATH:/github/bash-tools/spotify
ENV PATH $PATH:/github/bash-tools/terraform

ADD https://raw.githubusercontent.com/nholuongut/DevOps-Bash-tools/master/setup/docker_bootstrap.sh /build.sh

RUN chmod +x /build.sh && NO_TESTS=1 /build.sh

# Cache Bust upon new commits
ADD https://api.github.com/repos/nholuongut/DevOps-Bash-tools/git/refs/heads/master /.git-hashref

ADD https://raw.githubusercontent.com/nholuongut/Dockerfiles/master/src/list_shell.sh /list.sh

# 2nd run is almost a noop without cache, and only an incremental update upon cache bust
RUN chmod +x /list.sh && /build.sh

WORKDIR /github/bash-tools

CMD ["/list.sh", "/github/bash-tools"]
