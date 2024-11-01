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

echo "checking docker image calls match directory tree"
for directory in *; do
    [ -d "$directory" ] || continue
    [ "$directory" = "bash-tools" ] && continue
    [ "$directory" = "pytools_checks" ] && continue
    [ "$directory" = "teamcity" ] && continue
    [ -f "$directory/docker-compose.yml" ] || continue
    # exclude things not in Git yet
    git log -1 "$directory" 2>/dev/null | grep -q '.' || continue
    for compose_file in "$directory/"*docker-compose*.yml; do
        # this allows us to skip things like rabbitmq-cluster
        if grep -q image "$compose_file"; then
            image_name_alternate="${directory%-*}"
            image_tag_alternate="${directory##*-}"
            if ! grep -Eq \
                 -e "^[[:space:]]*image:[[:space:]]*nholuongut/$directory(:\\$\\{VERSION:-latest\\}|:latest)?[[:space:]]*$" \
                 -e "^[[:space:]]*image:[[:space:]]*nholuongut/${image_name_alternate}(:\\$\\{VERSION:-$image_tag_alternate\\}|:$image_tag_alternate)?[[:space:]]*$" "$compose_file"; then
                echo "$directory docker-compose.yml image mismatch!"
                exit 1
            fi
        fi
    done
done
echo "OK: Docker-compose images matched expected names for directory tree"
