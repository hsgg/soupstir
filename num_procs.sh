#!/bin/sh

source "`dirname "$0"`/config"

get_user.sh | grep -v "^freecores none" | wc -l
