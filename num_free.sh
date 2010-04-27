#!/bin/sh

source "`dirname "$0"`/config"

# To determine the number of free cores, we cannot just use the value
# reported by cfree.sh, because overcommits are counted as negatives.

get_user.sh | grep "^freecores none" | wc -l
