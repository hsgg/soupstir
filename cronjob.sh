#!/bin/sh

outfile="/home/gebhardt/cluster/logs/log-`date +%Y%m%d-%H%M`"
mkdir -p logs

echo $outfile
echo

PATH="$PATH:/home/gebhardt/cluster"

all.sh -q | tee "$outfile" | statistics.sh

# This will also appear in the mail:
echo
echo "Unnice:"
cat "$outfile" | get_unniced.sh | get_user.sh | histogram.py

chmod -w "$outfile"
