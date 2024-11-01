#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
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

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

export JAVA_HOME="${JAVA_HOME:-/usr}"

export PATH="$PATH:/hadoop/sbin:/hadoop/bin"

if [ $# -gt 0 ]; then
    exec "$@"
else
    for tuple in root,root hdfs,/home/hdfs yarn,/home/yarn; do
        IFS=',' read -r x xhome <<< "${tuple}"
        if ! [ -f "$xhome/.ssh/id_rsa" ]; then
            su - "$x" <<-EOF
                [ -n "${DEBUG:-}" ] && set -x
                ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
EOF
        fi
        if ! [ -f "$xhome/.ssh/authorized_keys" ]; then
            su - "$x" <<-EOF
                [ -n "${DEBUG:-}" ] && set -x
                cp -v ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
                chmod -v 0400 ~/.ssh/authorized_keys
EOF
        fi
    done

    # removed in newer versions of CentOS
    if ! [ -f /etc/ssh/ssh_host_rsa_key ] && [ -x /usr/sbin/sshd-keygen ]; then
        /usr/sbin/sshd-keygen || :
    fi
    if ! [ -f /etc/ssh/ssh_host_rsa_key ]; then
        ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''
        chmod 0600 /etc/ssh/ssh_host_rsa_key
        chmod 0644 /etc/ssh/ssh_host_rsa_key.pub
    fi

    if ! pgrep -x sshd &>/dev/null; then
        /usr/sbin/sshd
    fi
    echo
    SECONDS=0
    while true; do
        if ssh-keyscan localhost 2>&1 | grep -q OpenSSH; then
            echo "SSH is ready to rock"
            break
        fi
        if [ "$SECONDS" -gt 20 ]; then
            echo "FAILED: SSH failed to come up after 20 secs"
            exit 1
        fi
        echo "waiting for SSH to come up"
        sleep 1
    done
    echo
    if ! [ -f /root/.ssh/known_hosts ]; then
        ssh-keyscan localhost || :
        ssh-keyscan 0.0.0.0   || :
    fi | tee -a /root/.ssh/known_hosts
    hostname="$(hostname -f)"
    if ! grep -q "$hostname" /root/.ssh/known_hosts; then
        ssh-keyscan "$hostname" || :
    fi | tee -a /root/.ssh/known_hosts

    mkdir -pv /hadoop/logs

    sed -i "s/localhost/$hostname/" /hadoop/etc/hadoop/core-site.xml

    start-dfs.sh
    start-yarn.sh
    tail -f /dev/null /hadoop/logs/*
    stop-yarn.sh
    stop-dfs.sh
fi
