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

export SOLR_HOME="/solr"

cd "$SOLR_HOME"

# Solr 5+ insists on SOLR_HOME being set to /solr/server/solr dir containing solr.xml
set +o pipefail # in case solr version doesn't exist in older versions
if [ "$(solr version|cut -c 1)" -ge 5 ]; then
    export SOLR_HOME="$SOLR_HOME/server/solr"
    solr start -f
else
    cd "$SOLR_HOME/example"
    java -jar start.jar
fi
