#!/bin/sh

source "`dirname "$0"`/config"

cat "$logdir"/* \
	| grep -v "freecores *none" \
	| grep '^.*: [RS] ' \
	| cut -d' ' -f3 \
	| histogram.py \
	| sort -g \
	| cut -f1,2
