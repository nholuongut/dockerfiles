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
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir/.."

echo "checking no Dockerfiles do ADD/COPY ."
for directory in *; do
    [ -d "$directory" ] || continue
    [ -f "$directory/Dockerfile" ] || continue
    if grep '(ADD|COPY)[[:space:]]+\.' "$directory/Dockerfile"; then
        echo "$directory/Dockerfile contains ADD/COPY . - dangerous this is how you leak credentials!!"
        exit 1
    fi
done
