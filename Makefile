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

ifneq ("$(wildcard bash-tools/Makefile.in)", "")
	include bash-tools/Makefile.in
endif

# On Ubuntu this fails to pushd otherwise
# fails to bootstrap on Alpine
#SHELL := /usr/bin/env bash

REPO := nholuongut/Dockerfiles

CODE_FILES := $(shell find . -type f -name '*.py' -o -type f -name '*.sh' -o -type f -name Dockerfile | grep -v -e bash-tools)

# EUID /  UID not exported in Make
# USER not populated in Docker
#ifeq '$(shell id -u)' '0'
#	SUDO =
#	SUDO2 =
#else
#	SUDO = sudo
#endif

.PHONY: build
build: init
	@echo "==========="
	@echo "Dockerfiles"
	@echo "==========="
	@#$(MAKE) git-summary
	@$(MAKE) system-packages

.PHONY: init
init:
	git submodule update --init --recursive

.PHONY: all
all: build test docker-build
	@:

.PHONY: docker-build
docker-build:
	# do not just break as it will fail and move to next push target in build-push
	for x in *; do \
		[ -f "$$x/Dockerfile" ] || continue; \
		[ -f "$$x/Makefile" ] || continue; \
		tests/exclude.sh "$$x" && continue; \
		echo "building: $$x" && \
		cd "$$x" && \
		$(MAKE) build && \
		echo && \
		cd - || \
		exit 1; \
	done

.PHONY: build-push
build-push: docker-build docker-push
	:

tags:
	./build_tags.sh

.PHONY: nocache
nocache:
	for x in *; do \
		[ -f "$$x/Dockerfile" ] || continue; \
		[ -f "$$x/Makefile" ] || continue; \
		tests/exclude.sh "$$x" && continue; \
		echo "building without cache: $$x" && \
		cd "$$x" && \
		$(MAKE) nocache && \
		echo && \
		cd - || \
		exit 1; \
	done

#.PHONY: apt-packages
#apt-packages:
#	$(SUDO) apt-get update
#	$(SUDO) apt-get install -y npm
#	$(SUDO) apt-get install -y which
#
#.PHONY: yum-packages
#yum-packages:
#	rpm -q rpm || $(SUDO) yum install -y npm
#	rpm -q rpm || $(SUDO) yum install -y which
#
#.PHONY: test-deps
#test-deps:
#	if [ -x /usr/bin/apt-get ]; then $(MAKE) apt-packages; fi
#	if [ -x /usr/bin/yum ];     then $(MAKE) yum-packages; fi
#	# this is clearly too basic - it doesn't even recognize LABEL instruction, nor line continuations
#	which docklint &>/dev/null || npm install -g validate-dockerfile

.PHONY: test
test:
	@# this would test everything but would call test-deps over and over inefficiently
	@#for x in *; do [ -d $$x ] || continue; cd "$$x"; $(MAKE) test; cd -; done
	@#$(MAKE) test-deps
	@#find . -name Dockerfile | xargs -n1 docklint
	tests/all.sh

.PHONY: push
push:
	git push --all

.PHONY: pull
pull:
	git checkout master && \
	git pull --no-edit && \
	for branch in $$(git branch -a | grep -v -e remotes/ | sed 's/\*//'); do \
		echo "git checkout $$branch" && \
		git checkout "$$branch" && \
		echo "git pull --no-edit" && \
		git pull --no-edit || \
		exit 1; \
	done; \
	git checkout master

.PHONY: dockerpull
dockerpull:
	for x in *; do [ -d $$x ] || continue; docker pull nholuongut/$$x || exit 1; done

.PHONY: docker-push
docker-push:
	# use make push which will also call hooks/post_build
	for x in *; do \
		[ -d "$$x" ] || continue; \
		tests/exclude.sh "$$x" && continue; \
		cd "$$x" && \
		$(MAKE) push && \
		cd - || \
		exit 1; \
	done

.PHONY: sync-hooks
sync-hooks:
	# some hooks are different to the rest so excluded, not git checkout overwritten in case they have pending changes
	latest_hook=`ls -t */hooks/post_build | grep -Ev -e github -e '(alpine|centos|debian|fedora|ubuntu)-dev' -e "nagios-plugins" | head -n1`; \
	for x in */hooks/post_build; do \
		if [[ "$$x" =~ nagios-plugins ]] || \
		   [[ "$$x" =~ github ]] || \
		   [[ "$$x" =~ (alpine|centos|debian|fedora|ubuntu)-dev ]] || \
		   [[ "$$x" =~ devops-.*-tools ]]; then \
			continue; \
		fi; \
		if git status --porcelain "$$x/hooks/post_build" | grep -q '^.M'; then \
			echo "$$x/hooks/post_build has pending modifications, skipping..."; \
			continue; \
		fi; \
		if [ "$$latest_hook" != "$$x" ]; then \
			cp -v "$$latest_hook" "$$x"; \
		fi; \
	done
	echo
	latest_hook=`ls -t *github/hooks/post_build | head -n1`; \
	for x in *-github/hooks/post_build; do \
		if git status --porcelain "$$x/hooks/post_build" | grep -q '^.M'; then \
			echo "$$x/hooks/post_build has pending modifications, skipping..."; \
			continue; \
		fi; \
		if [ "$$latest_hook" != "$$x" ]; then \
			cp -v "$$latest_hook" "$$x"; \
		fi; \
	done
	echo
	latest_hook=`ls -t {alpine,centos,debian,fedora,ubuntu}-dev/hooks/post_build | head -n1`; \
	for x in {alpine,centos,debian,fedora,ubuntu}-dev/hooks/post_build; do \
		if git status --porcelain "$$x/hooks/post_build" | grep -q '^.M'; then \
			echo "$$x/hooks/post_build has pending modifications, skipping..."; \
			continue; \
		fi; \
		if [ "$$latest_hook" != "$$x" ]; then \
			cp -v "$$latest_hook" "$$x"; \
		fi; \
	done

.PHONY: sync-builds
sync-builds:
	# some hooks are different to the rest so excluded, not git checkout overwritten in case they have pending changes
	latest_hook=`ls -t devops-*-tools-*/build.sh | grep -v alpine | head -n1`; \
	for x in devops-*-tools-*/build.sh; do \
		if [[ "$$x" =~ alpine ]]; then \
			continue; \
		fi; \
		if git status --porcelain "$$x/build.sh" | grep -q '^.M'; then \
			echo "$$x/build.sh has pending modifications, skipping..."; \
			continue; \
		fi; \
		if [ "$$latest_hook" != "$$x" ]; then \
			cp -v "$$latest_hook" "$$x"; \
		fi; \
	done
	echo
	latest_hook=`ls -t devops-*-tools-alpine/build.sh | head -n1`; \
	for x in devops-*-tools-alpine/build.sh; do \
		if git status --porcelain "$$x/build.sh" | grep -q '^.M'; then \
			echo "$$x/build.sh has pending modifications, skipping..."; \
			continue; \
		fi; \
		if [ "$$latest_hook" != "$$x" ]; then \
			cp -v "$$latest_hook" "$$x"; \
		fi; \
	done

.PHONY: commit-hooks
commit-hooks:
	git commit -m "updated post build hooks" `git status -s */hooks | grep ^.M | awk '{print $$2}'`

.PHONY: commit-builds
commit-builds:
	git commit -m "updated */build.sh" `git status -s */build.sh | grep ^.M | awk '{print $$2}'`

# TODO: finish and remove ranger
.PHONY: post-build
post-build:
	@for x in *; do \
		[ -d "$$x" ] || continue; \
		[ "$$x" = h2o ] && continue; \
		[ "$$x" = presto-dev ] && continue; \
		[ "$$x" = ranger ] && continue; \
		[ "$$x" = riak ] && continue; \
		[ "$$x" = teamcity ] && continue; \
		if [ -f "$$x/hooks/post_build" ]; then \
			echo "$$x/hooks/post_build"; \
			"$$x/hooks/post_build" || exit 1; \
			echo; \
		fi; \
	done
.PHONY: postbuild
postbuild: post-build
	:

.PHONY: mergemaster
mergemaster:
	bash-tools/git/git_merge_master.sh

.PHONY: mergemasterpull
mergemasterpull:
	bash-tools/git/git_merge_master_pull.sh

.PHONY: mergeall
mergeall:
	bash-tools/git/git_merge_all.sh

# this would apply to all recipes
#.ONESHELL:
.PHONY: nagios-plugins
nagios-plugins:
	for x in nagios-plugins*; do \
		cd "$$x" && \
		$(MAKE) nocache push; \
		cd -; \
	done
	docker images | grep nagios-plugins

.PHONY: nagios
nagios: nagios-plugins
	:

.PHONY: perl-tools
perl-tools:
	for x in devops-perl-tools-*; do \
		cd "$$x" && \
		$(MAKE) nocache push; \
		cd -; \
	done
	docker images | grep perl-tools

.PHONY: pytools
pytools: python-tools
	@:

.PHONY: python-tools
python-tools:
	for x in devops-python-tools-*; do \
		cd "$$x" && \
		$(MAKE) nocache push; \
		cd -; \
	done
	docker images | grep pytools

.PHONY: build-github
build-github:
	# has no test target, consider adding one
	for x in *-github; do \
		cd "$$x" && \
		$(MAKE) nocache push; \
		cd -
	done
	docker images | grep github

.PHONY: status
status:
	@tests/check_dockerhub_statuses.sh

# build a locally named obvious docker image with the git checkout dir and subdirectories for testing purposes
# -  with a tag of the Git Commit Short Sha hashref of this current commit +
# - a unique checksum of the list of files changed as a 'dirty' differentiator
# - to compare the different resulting docker image sizes from
# - the current commit's version of the Dockerfile
#     vs
# - the currently modified Dockerfile
#
#.PHONY: docker-build-hashref
#docker-build-hashref:
#    set -euxo pipefail; \
#    git_commit_short_sha="$$(git rev-parse --short HEAD)"; \
#    git_root="$$(git rev-parse --show-toplevel)"; \
#    git_root_dir="$${git_root##*/}"; \
#    git_path="$${git_root_dir}/$${PWD##$$git_root/}"; \
#    image_name="$${git_path////--}"; \
#    dirty=""; \
#    if git status --porcelain | grep -q . ; then \
#        dirty="-dirty-$$(git status --porcelain | md5sum | cut -c 1-7)"; \
#    fi; \
#    docker build . -t "$${image_name}:$${git_commit_short_sha}$${dirty}" &&
#    docker images | grep "^$$image_name"
