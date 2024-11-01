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

# shellcheck disable=SC1091
. "bash-tools/lib/utils.sh"

# Checks ports exposed by docker-compose and Makefile run target are the same to catch things like HBase versions having different port numbers and making sure they were updated in both places

width=0
for x in *; do
    [ -d "$x" ] || continue
    if [ ${#x} -gt $width ]; then
        width=${#x}
    fi
done

for x in *; do
    [ -d "$x" ] || continue
    if ! [ -f "$x/docker-compose.yml" ]; then
        #echo "no docker-compose.yml found, skipping..."
        continue
    fi
    printf "checking ports for %-${width}s => " "$x"
    # using Perl because sed requires ERE for .+ which uses a different switch on Max OSX (-E) vs Linux (-r)
    ports=$(perl -ne 'print "$1\n" if /\s+-\s*(\d{4,5})(:\d{4,5})?\s*$/' "$x/"*docker-compose*.yml)
    if [ -z "$ports" ]; then
        echo "no ports found"
        continue
    fi
    expected_port_mapping=""
    for port in $ports; do
        expected_port_mapping="$expected_port_mapping-p $port:$port "
    done
    if ! grep -q '^[^#]*docker run' "$x/Makefile"; then
        echo "no docker run, skipping"
        continue
    fi
    if grep -q -- "$expected_port_mapping" "$x/Makefile"; then
        echo "OK"
    else
        echo "FAILED"
        port_mapping="$(perl -ne 'print $1 if /docker\s+run\s+.*?(-p.*)\s+\$/' "$x/Makefile")"
        echo
        echo "expected port mapping not found: $expected_port_mapping"
        echo "                  instead found: $port_mapping"
        exit 1
    fi
done
echo
echo
