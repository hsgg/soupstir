#!/bin/sh

source "`dirname "$0"`/config"

grep -v "freecores *none" \
	| grep '^.*: [DRSTXZ] ' \
	| tr -s ' ' \
	| cut -d' ' -f3 \
	| histogram.py \
	| sort -g
