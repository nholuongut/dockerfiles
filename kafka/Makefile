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

REPO := nholuongut/kafka

# override TAG with more specific Scala_Kafka version
TAG = $(shell perl -n -e '/^\s*ARG\s+SCALA_VERSION\s*=\s*(\d+\.\d+)/ && print "$$1"; ' Dockerfile)_$(shell perl -n -e '/^\s*ARG\s+KAFKA_VERSION\s*=\s*(\d+\.\d+)/ && print "$$1"; ' Dockerfile)

MAP_PORTS := 2181 9092

include ../Makefile.in
