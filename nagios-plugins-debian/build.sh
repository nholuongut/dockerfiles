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

# just for check_puppet.rb, but it doesn't make sense to use that plugin in a container as it's a local style plugin
#apt-get install -y ruby

if ! [ -d "/github/$repo" ]; then
    git clone "https://github.com/nholuongut/$repo" "/github/$repo"
    cd "/github/$repo"
    git submodule update --init --recursive
fi

cd "/github/$repo"

git pull

git submodule update --init --recursive

make update zookeeper

make apt-packages-remove

apt-get autoremove -y

apt-get clean

# run tests after autoremove to check that no important packages we need get removed
make test deep-clean

# leave git it's needed for Git-Python and check_git_branch_checkout.pl/py
# leave make for easier updates
#apt-get remove -y make

apt-get autoremove -y

apt-get clean

bash-tools/checks/check_docker_clean.sh

# basic test for missing dependencies again
tests/help.sh
