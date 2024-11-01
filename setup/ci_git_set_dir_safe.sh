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


# Necessary for some CI/CD systems like Azure DevOps Pipelines which have incorrect ownership on the git checkout dir triggering this error:
#
#    fatal: detected dubious ownership in repository at '/code/sql'

# standalone script without lib dependency so it can be called directly from bootstrapped CI before submodules, since that is the exact problem that needs to be solved to allow CI/CD systems with incorrect ownership of the checkout directory to be able to checkout the necessary git submodules

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dir="${1:-$srcdir/..}"

cd "$dir"

echo "Setting directory as safe: $PWD"
git config --global --add safe.directory "$PWD"

while read -r submodule_dir; do
    dir="$PWD/$submodule_dir"
    echo "Setting directory as safe: $dir"
    git config --global --add safe.directory "$dir"
done < <(git submodule | awk '{print $2}')

echo "Done"
