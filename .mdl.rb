#!/usr/bin/env ruby
#  vim:ts=4:sts=4:sw=4:et:filetype=ruby
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


all
#exclude_rule 'MD001'
#exclude_rule 'MD003'
#exclude_rule 'MD005'
exclude_rule 'MD007'  # leave 2 space indentation for lists, 3 space is ugly af
#exclude_rule 'MD012'
exclude_rule 'MD013'  # long lines cannot be split if they are URLs
#exclude_rule 'MD022'
#exclude_rule 'MD025'
#exclude_rule 'MD031'
#exclude_rule 'MD032'
exclude_rule 'MD033'  # inline HTML is important for formatting
exclude_rule 'MD036'  # emphasis used instead of header for footer Ported from lines
#exclude_rule 'MD039'
#exclude_rule 'MD056'
