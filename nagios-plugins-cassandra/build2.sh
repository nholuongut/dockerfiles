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

nagios_plugins="/github/nagios-plugins"

bash_tools="$nagios_plugins/bash-tools"

#cd "$nagios_plugins"

#git pull
#make update2

#cd bash-tools
#git pull origin master

cd /

"$bash_tools/setup/download_cassandra.sh"

yum clean all

rm -rf /var/cache/yum

"$bash_tools/checks/check_docker_clean.sh"
