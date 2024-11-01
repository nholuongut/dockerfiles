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


# NOT USED

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# busybox's egrep and sed ERE are broken, don't recognize \. - doing something a bit more basic but it works
ip="$(ifconfig | grep -m1 'inet addr:' | sed 's/.*inet addr://;s/ .*$//')"

# none of this seems necessary with serf
args=""
if [ $# -eq 0 ] || [ "${1:-}" = "agent" ]; then
    args="-bind $ip -rpc-addr $ip:7373"
fi

# want arg splitting
# shellcheck disable=SC2086
exec /serf "$@" $args
