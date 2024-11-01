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

set -euxo pipefail
[ -n "${DEBUG:-}" ] && set -x

mkdir -pv /github

repo=nagios-plugins

apt-get update

apt-get install -y git make

if ! [ -d "/github/$repo" ]; then
    git clone "https://github.com/nholuongut/$repo" "/github/$repo"
    cd "/github/$repo"
    git submodule update --init --recursive
fi

cd "/github/$repo"

make python

make system-packages-remove

apt-get autoremove -y

apt-get clean

#EXT=py make deep-clean test

# run tests after autoremove to check that no important packages we need get removed
pushd pylib
make test deep-clean
popd

# leave git it's needed for Git-Python and check_git_branch_checkout.pl/py
# leave make, it's needed for quick updates
#apt-get purge -y make

apt-get autoremove -y

apt-get clean

bash-tools/checks/check_docker_clean.sh

find . -name '*.pl' -exec rm -v {} \;

# basic test for missing dependencies again
tests/help.sh

rm -fr bash-tools lib pylib/bash-tools
