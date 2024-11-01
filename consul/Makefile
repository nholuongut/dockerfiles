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

REPO := nholuongut/consul

include ../Makefile.in

run:
	# -dev flag >= 0.6 only, use -server -bootstrap instead
	docker run -ti -p 8500:8500 $(REPO):$(TAG) agent -server -bootstrap -data-dir /tmp -client 0.0.0.0
