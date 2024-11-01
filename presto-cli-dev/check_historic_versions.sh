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

cd "$srcdir"

# shellcheck disable=SC1090
. "$srcdir/../bash-tools/lib/utils.sh"

section "Presto CLI - validating Development Versions"

#no_cache=""
#if [ -n "${NOCACHE:-}" ]; then
#    no_cache="--no-cache"
#fi

if [ -n "$*" ]; then
    versions_to_check="$*"
else
    # do not build latest version by default, leave that to automated build
    # originally did ../presto-dev/get_presto_versions.sh but it's needed inside the Dockerfile too to determine the latest version so much exist in this local context anyway
    versions_to_check="$(./get_presto_versions.sh)"
fi

count=0
fail=0

for orig_version in latest $versions_to_check; do
    section2 "Checking Presto CLI version $orig_version"
    version="$orig_version"
    if [ "$orig_version" = "latest" ]; then
        version="$(./get_presto_versions.sh | head -n1)"
    fi
    ((count+=1))
    echo "determining presto cli version from container"
    found_version=$(docker run --rm -ti "nholuongut/presto-cli-dev:$orig_version" --version | awk '{print $3}' | tr -d '\r')
    echo
    if [ "$found_version" = "$version" ]; then
        echo "VALIDATED: nholuongut/presto-cli-dev:$orig_version contains:  $found_version"
    else
        fail=1
        echo "INVALID: nholuongut/presto-cli-dev:$orig_version contains wrong version of presto, found:  $found_version !!!"
    fi
    echo
    if [ $count -gt 1 ]; then
        docker rmi "nholuongut/presto-cli-dev:$orig_version"
    fi
    echo
done

echo
if [ $fail -eq 0 ]; then
    echo "Successfully validate $count versions of Presto CLI"
else
    echo "Validation of Presto CLI versions failed"
fi
