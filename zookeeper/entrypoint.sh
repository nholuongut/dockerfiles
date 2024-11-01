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

# 3.3 fails to start the first time with this dir
mkdir -p /tmp/zookeeper
# zookeeper.out will be written to $PWD
cd /tmp
zkServer.sh start
sleep 2
if [ -t 0 ]; then
    zkCli.sh
    echo -e '\n\nZooKeeper shell exited\n'
else
    echo "
Running non-interactively, will not open ZooKeeper shell

For ZooKeeper shell start this image with 'docker run -t -i' switches
"
fi
echo -e '\nWill tail log now to keep this container alive until killed...\n\n'
sleep 30
tail -f /dev/null zookeeper.out &
wait || :
