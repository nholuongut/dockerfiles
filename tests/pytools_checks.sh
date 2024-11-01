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

# shellcheck disable=SC1090
. "$srcdir/../bash-tools/lib/utils.sh"

section "Dockerfiles PyTools Checks"

export PROJECT=Dockerfiles

# start time is run in here
# shellcheck disable=SC1090
. "$srcdir/../bash-tools/checks/check_pytools.sh"

# set in check_pytools.sh
# shellcheck disable=SC2154
if [ -n "${skip_checks:-}" ]; then
    exit 0
fi

pushd "$srcdir/.."

dockerfiles_check_git_branches.py .
echo

git_check_branches_upstream.py --fix .
echo

popd

# start_time is defined in check_pytools.sh imported above
# shellcheck disable=SC2154
time_taken "$start_time"
section2 "PyTools validations SUCCEEDED"
echo
