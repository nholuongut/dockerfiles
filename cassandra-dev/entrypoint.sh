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

if [ "$*" ]; then
    "$@"
else
    # recent versions 3.5+ refuse to run as root
    #cassandra
    su cassandra "$(type -P cassandra)"
    count=0
    while true; do
        logfile="/cassandra/logs/system.log"
        [ -f "/var/log/cassandra/system.log" ] &&
            logfile="/var/log/cassandra/system.log"
        grep 'Starting listening for CQL clients' "$logfile" && break
        ((count+=1))
        if [ $count -gt 20 ]; then
            echo
            echo
            echo "Didn't find CQL startup in cassandra system.log, trying CQL anyway"
            break
        fi
        echo -n .
        sleep 1
    done
    echo
    echo
    # bug workaround
    # https://issues.apache.org/jira/browse/CASSANDRA-11850
    export CQLSH_NO_BUNDLED=TRUE
    #cqlsh
    if [ -t 0 ]; then
        bind_address="$(netstat -lnt | awk '/:9042/{print $4}' | sed 's/:[[:digit:]]*.*//')"
        cqlsh="$(type -P cqlsh)"
        echo "su cassandra $cqlsh $bind_address"
        su cassandra "$cqlsh" "$bind_address"
        echo -e '\n\nCQL shell exited'
    else
        echo "
    Running non-interactively, will not open CQL shell

    For CQL shell start this image with 'docker run -t -i' switches

    "
    fi
    echo -e '\n\nWill tail logs now to keep this container alive until killed...\n\n'
    sleep 30
    tail -f /dev/null /cassandra/logs/* &
    wait || :
fi
