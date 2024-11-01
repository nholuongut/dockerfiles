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

# Because DockerHub is awfully slow to get round to doing builds

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$srcdir"

selection="${1:-}"

tags=$(git tag)

for tag in $tags; do
    tag_base="${tag%%-[[:digit:]]*}"
    tag_version="${tag##*[[:alpha:]]-}"
    [ -n "$selection" ] && [ "$selection" != "$tag_base" ] && continue
    echo "checking out tag $tag"
    git checkout "$tag"
    find . -maxdepth 1 -type d |
    while read -r directory; do
        directory="${directory##*/}"
        if [ "$directory" = "$tag_base" ]; then
            pushd "$directory" &>/dev/null
            docker build -t "nholuongut/$tag_base:$tag_version" .
            popd &>/dev/null
        fi
    done
done
