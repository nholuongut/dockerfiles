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

# solr -e cloud fails if not called from $SOLR_HOME
cd "$SOLR_HOME"

# exits with 141 for pipefail breaking yes stdout
set +o pipefail
solr -e cloud -noprompt
if ls -d "$SOLR_HOME"-4* &>/dev/null; then
    tail -f /dev/null "$SOLR_HOME"/node*/logs/*
else
    tail -f /dev/null "$SOLR_HOME"/example/cloud/node*/logs/*
fi
