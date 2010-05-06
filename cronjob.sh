#!/bin/sh

source "`dirname "$0"`/config"

outfile="$logdir/log-`date +%Y%m%d-%H%M`"
mkdir -p "$logdir"

echo $outfile
echo

all.sh -q | tee "$outfile" | statistics.sh

# This will also appear in the mail:
echo
echo "Unnice:"
cat "$outfile" | get_unniced.sh | get_user.sh | histogram.py

chmod -w "$outfile"
