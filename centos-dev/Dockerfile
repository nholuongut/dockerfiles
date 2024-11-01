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

ENV GRADLE_HOME=/opt/gradle
ENV JYTHON_HOME=/opt/jython
ENV PATH $PATH:$GRADLE_HOME/bin:$JYTHON_HOME/bin

# behaviour has changed in RHEL 8 - dnf doesn't install any packages if any of them can't be found
RUN bash -c ' \
    set -euxo pipefail && \
    sed -i "s/^[[:space:]]*mirrorlist/#mirrorlist/" /etc/yum.repos.d/CentOS-* && \
    sed -i "s|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|" /etc/yum.repos.d/CentOS-* && \
    for x in \
    bind-utils \
    curl \
    cyrus-sasl-devel \
    dstat \
    expat-devel \
    expect \
    ethtool \
    fping \
    gcc \
    gcc-c++ \
    git \
    groovy \
    hostname \
    httping \
    libev \
    libev-devel \
    lsof \
    make \
    maven \
    mysql-devel \
    nc \
    net-tools \
    nmap \
    nmap-ncat \
    openssl-devel \
    perl \
    perl-CPAN \
    #perl-App-cpanminus \
    perl-DBD-MySQL \
    perl-libwww-perl \
    procps \
    python \
    python-devel \
    python-pip \
    python-setuptools \
    python2 \
    python2-devel \
    python2-pip \
    python2-setuptools \
    python3 \
    python3-devel \
    python3-pip \
    python3-setuptools \
    ruby \
    ruby-devel \
    snappy-devel \
    socat \
    strace \
    sysstat \
    tar \
    tcpdump \
    unzip \
    vim-enhanced \
    wget \
    which \
    yum-plugin-security \
    yum-security \
    zip \
    epel-release \
    jwhois; do \
        rpm -q "$x" >/dev/null || yum install -y "$x" || :; \
    done; \
    curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/install/install_sbt.sh | bash -x && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    # workaround for CentOS (found via strace) otherwise incorrectly states "Warning: You do not have write permission for Perl library directories." and local::lib hits use of uninitialized variables errors in base modules like even core File::Basename :-/
    mkdir -v /usr/local/share/perl5 /usr/local/lib64/perl5 \
    '

# Gradle doesn't have an RPM :-(
RUN set -eux && \
    wget https://raw.githubusercontent.com/nholuongut/bash-tools/master/install/install_gradle.sh && \
    bash install_gradle.sh && \
    rm -f install_gradle.sh

# Jython
RUN set -eux && \
    wget https://raw.githubusercontent.com/nholuongut/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/nholuongut/devops-python-tools/master/jython_autoinstall.exp && \
    bash jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp

CMD ["/bin/bash"]
