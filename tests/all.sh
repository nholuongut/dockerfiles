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
srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$srcdir/.."

# shellcheck disable=SC1091
. bash-tools/lib/utils.sh

section "Dockerfiles checks"

tests/pytools_checks.sh

# in Travis we only test master branch
# - don't want PyTools checks applying to all branches because
#   they already check out every branch to test alignment of version numbers before commit + push
#   doing CI against every branch would become a multiplier of all branches vs all branches
#
# XXX: doesn't work Travis fails to check out any branches
#if ! is_CI; then
#if ! is_travis; then
if false; then
    branches="$(
    git ls-remote |
    awk '/\/heads\//{print $2}' |
    sed 's,^refs/heads/,,' |
    sed '
    s/^\* // ;
    s/.*\/// ;
    s/^[[:space:]]*// ;
    s/[[:space:]]*$// ;
    s/.*[[:space:]]// ;
    s/)[[:space:]]*//
    ' |
    sort -u
    )"
    for branch in $branches; do
        tests/tests_per_branch.sh "$branch"
    done
else
    tests/tests_per_branch.sh
fi

tests/projects_without_docker-compose_yet.sh

tests/projects_without_README_yet.sh

tests/check_for_new_versions.sh
