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

# Checks the status of all the DockerHub builds
#
# Needs check_dockerhub_repo_build_status.py to be in $PATH, from Advanced Nagios Plugins Collection

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir/.."

# using git grep skips bash-tools/Makefile in submodule as well as any uncommitted Makefiles for new docker images
#awk -F= '/REPO.*=/{print $$2}' */Makefile
git grep -h 'REPO.*=' -- */Makefile |
awk -F= '{print $2}' |
sed 's/:/ /g' |
sort -u |
while read -r repo tag; do
    echo -n "$repo"
    opts=""
    if [ -n "$tag" ]; then
        opts="--tag $tag"
        echo -n "($tag)"
    fi
    echo -n ":  "
    # want opts splitting
    # shellcheck disable=SC2086
    check_dockerhub_repo_build_status.py --repo "$repo" --pages 3 $opts || :
done
