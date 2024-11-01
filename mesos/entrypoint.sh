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

if [ $# -gt 0 ]; then
    exec "$@"
else
    # This only runs a master
    #/usr/bin/mesos-local
    echo "Starting Mesos Master:"
    mesos master --work_dir=/var/lib/mesos --log_dir=/tmp/mesos-master-logs --cluster=myCluster &
    sleep 2
    echo "Starting Mesos Worker:"
    set +eo pipefail
    ip_address="$(ifconfig | awk '/inet addr/{print $2; exit}' | sed 's/.*://')"
    if [ -z "$ip_address" ]; then
        echo "FAILED to find IP Address, cannot launch worker as will get expected master mismatch"
        exit 1
    fi
    set -eo pipefail
    mesos slave --master="$ip_address:5050" --log_dir=/tmp/mesos-slave-logs --no-systemd_enable_support --launcher=posix &
    sleep 1
    echo "================="
    cat /tmp/mesos-master-logs/* || :
    cat /tmp/mesos-slave-logs/*  || :
    tail -f /dev/null /tmp/mesos-master-logs/* /tmp/mesos-slave-logs/*
fi
