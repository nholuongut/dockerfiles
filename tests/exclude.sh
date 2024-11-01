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

# dirs to exclude from iterating in Makefiles
exclude_list="
bash-tools
old
ranger
tests
"

for excluded in $exclude_list; do
    if [ "${1:-}" = "$excluded" ]; then
        exit 0
    fi
done

exit 1
