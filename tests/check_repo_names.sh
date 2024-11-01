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

echo "checking repo names match directory tree"
for directory in *; do
    [ -d "$directory" ] || continue
    [ "$directory" = "bash-tools" ] && continue
    [ "$directory" = "pytools_checks" ] && continue
    #[[ "$directory" =~ devops-.*tools.* ]] && continue
    [ -f "$directory/Makefile" ] || continue
    # exclude things not in Git yet
    #git log -1 "$x" 2>/dev/null | grep -q '.*' || continue
    # shellcheck disable=SC2001
    repo="$(sed 's/\(.*nagios-plugins\)-\([[:alpha:]]*\)$/\1:\2/' <<< "$directory")"
    repo2="${repo%-*}:${repo##*-}"
    repo3="${repo2#devops-}"
    repo3="${repo3/python-tools/pytools}"
    repo3="${repo3/golang-tools/go-tools}"
    if ! grep -q -e "^REPO := nholuongut/$repo" \
                 -e "^REPO := nholuongut/$repo2" \
                 -e "^REPO := nholuongut/$repo3" \
                 "$directory/Makefile"; then
        echo "$directory Makefile REPO mismatch!"
        exit 1
    fi
done
