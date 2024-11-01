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

ADVERTISED_HOSTNAME="${ADVERTISED_HOSTNAME:-127.0.0.1}"

zookeeper-server-start.sh /kafka/config/zookeeper.properties &

echo "*** waiting for 10 secs to give ZooKeeper time to start up"

sleep 10

echo "# ============================================================================ #"
echo "                         S t a r t i n g   K a f k a"
echo "# ============================================================================ #"

perl -pi.orig -e "s/\\s*#?\\s*advertised.host.name.*/advertised.host.name=${ADVERTISED_HOSTNAME}/" "/kafka/config/server.properties"

kafka-server-start.sh /kafka/config/server.properties