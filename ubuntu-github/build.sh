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

mkdir -pv /github

cd /github

curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/install/install_sbt.sh | bash

if [ -n "$*" ]; then
    export REPOS="$*"
else
    export REPOS="bash-tools lib pylib perl-tools pytools" # spotify-tools
fi
curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/git/git_pull_make_repos.sh | bash

# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
#pip uninstall -y certifi && pip install certifi==2015.04.28

# could 'make deep-clean' to remove the wrappers and local build libs but it's a trade off between being able to develop quicker by not having to redownload them to recompile
# instead build each project with a different build tool and don't deep-clean so we have them cached for faster development in docker
export REPOS="lib-java" BUILD="gradle"
curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/git/git_pull_make_repos.sh | bash

export REPOS="nagios-plugin-kafka" BUILD="mvn"
curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/git/git_pull_make_repos.sh | bash

#export REPOS="spark-apps" BUILD="sbt"
#curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/git/git_pull_make_repos.sh | bash

# inherited instead now
#export REPOS="nagios-plugins" OPTS="zookeeper" NO_TEST=1
#curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/git/git_pull_make_repos.sh | bash

curl -sS https://raw.githubusercontent.com/nholuongut/bash-tools/master/bin/clean_caches.sh | sh
