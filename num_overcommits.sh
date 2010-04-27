#!/bin/sh

source "`dirname "$0"`/config"

# This is the process getting stdin
stdin="`cat`"


cores="`echo "$stdin" | num_cores.sh`"

virtual_procs="`echo "$stdin" | get_user.sh | wc -l`"

echo $(( $virtual_procs - $cores ))
