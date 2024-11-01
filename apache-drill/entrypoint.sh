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
#srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export JAVA_HOME="${JAVA_HOME:-/usr}"
export DRILL_HEAP="${DRILL_HEAP:-900M}"
export ZOOKEEPER_HOST="${ZOOKEEPER_HOST:-zookeeper}"

# for older versions
sed -i -e "s/-Xms1G/-Xms\$DRILL_MAX_HEAP/" apache-drill/conf/drill-env.sh
sed -i -e "s/^DRILL_MAX_HEAP=.*/DRILL_MAX_HEAP=\"${DRILL_HEAP}\"/" apache-drill/conf/drill-env.sh

sed -i -e "s/^DRILL_HEAP=.*/DRILL_HEAP=\"${DRILL_HEAP}\"/" apache-drill/conf/drill-env.sh
sed -i -e "s/^\\([[:space:]]*\\)zk.connect:.*/\\1zk.connect: \"${ZOOKEEPER_HOST}\"/" apache-drill/conf/drill-override.conf

if [ -t 0 ]; then
    # Embedded only
    # only works 1.0+
    #drill-embedded
    # backwards compatible for 0.x
    sqlline -u jdbc:drill:zk=local
else
    echo "
Running non-interactively, will not open Apache Drill SQL shell

For Apache Drill shell start this image with 'docker run -t -i' switches

Otherwise you will need to have a separate ZooKeeper container linked (one is available from nholuongut/zookeeper) and specify:

docker run -e ZOOKEEPER_HOST=<host>:2181 supervisord -n
"
fi
