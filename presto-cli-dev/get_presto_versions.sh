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
#srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# parse all versions, return numerically newest first (as you may want to Control-C but have the latest ones built by the point rather than have to wait for all the old versions before getting the newest one
get_presto_versions(){
    curl -sS https://repo1.maven.org/maven2/com/facebook/presto/presto-server/ |
    grep -Eo '>[[:digit:]]+\.[[:digit:]]+/' |
    sed 's/[>/]//g ; s/\./ /' |
    sort -rnk1 -k 2 |
    sed 's/ /./'
}

get_presto_versions
