#!/bin/sh

source "`dirname "$0"`/config"

outfile="$logdir/log-`date +%Y%m%d-%H%M`"
mkdir -p "$logdir"

echo $outfile
echo

all.sh -q | tee "$outfile" | statistics.sh

# This will also appear in the mail:
unnice="`cat "$outfile" | get_unniced.sh | get_user.sh | histogram.py | sort`"
if [ x"$unnice" != x"" ]; then
	echo
	echo "Unnice:"
	echo "$unnice"
fi

chmod -w "$outfile"
