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

#FROM nholuongut/fedora-scala:2.11-jdk8
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM nholuongut/fedora-scala:latest
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
LABEL org.opencontainers.image.description="Nho Luong" \
      org.opencontainers.image.version="$NhoLuong_VERSION" \
      org.opencontainers.image.authors="Nho Luong (https://www.linkedin.com/in/nholuong)" \
      org.opencontainers.image.documentation="https://hub.docker.com/u/nholu" \
      org.opencontainers.image.source="https://github.com/nholuongut/dockerfiles"

ENV GRADLE_HOME=/opt/gradle
ENV JYTHON_HOME=/opt/jython
ENV PATH $PATH:$GRADLE_HOME/bin:$JYTHON_HOME/bin

RUN bash -c ' \
    set -euxo pipefail && \
    yum install -y \
    curl \
    cyrus-sasl-devel \
    dstat \
    expat-devel \
    expect \
    ethtool \
    gcc \
    gcc-c++ \
    git \
    groovy \
    hostname \
    libev \
    libev-devel \
    make \
    maven \
    mysql-devel \
    net-tools \
    openssl-devel \
    perl \
    perl-CPAN \
    perl-App-cpanminus \
    perl-DBD-MySQL \
    perl-libwww-perl \
    python-devel \
    python-pip \
    python-setuptools \
    ruby \
    ruby-devel \
    snappy-devel \
    sysstat \
    tar \
    unzip \
    vim-enhanced \
    wget \
    which \
    yum-plugin-security \
    #yum-security \
    zip \
    jwhois && \
    curl -L https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y --nogpgcheck sbt && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    # workaround for CentOS (found via strace) otherwise incorrectly states "Warning: You do not have write permission for Perl library directories." and local::lib hits use of uninitialized variables errors in base modules like even core File::Basename :-/
    mkdir -v /usr/local/share/perl5 /usr/local/lib64/perl5 \
    '

# Gradle doesn't have an RPM :-(
RUN bash -c ' \
    set -euxo pipefail && \
    wget https://raw.githubusercontent.com/nholuongut/bash-tools/master/install/install_gradle.sh && \
    bash install_gradle.sh && \
    rm -f install_gradle.sh \
    '

# Jython
RUN bash -c ' \
    set -euxo pipefail && \
    wget https://raw.githubusercontent.com/nholuongut/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/nholuongut/devops-python-tools/master/jython_autoinstall.exp && \
    bash jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp \
    '

CMD ["/bin/bash"]
