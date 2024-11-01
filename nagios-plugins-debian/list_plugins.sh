#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
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

nagios_plugins="/github/nagios-plugins"

if [ -d "$HOME/github/nagios-plugins" ]; then
    nagios_plugins="$HOME/github/nagios-plugins"
fi

submodules="$(cd "$nagios_plugins"; git submodule status | awk '{print $2}')"

# shellcheck disable=SC2046
# trying to do -exec basename {} \; results in only the jython files being printed
find "$nagios_plugins" \
    -maxdepth 2 \
    -type f \
    -iname '[A-Za-z]*.sh' -o \
    -iname '[A-Za-z]*.pl' -o \
    -iname '[A-Za-z]*.py' |
grep -iv -e makefile -e lib_ -e /tests/ -e /setup/ \
         $(for submodule in $submodules; do echo -n "-e $submodule "; done) |
xargs -n1 basename |
sort
