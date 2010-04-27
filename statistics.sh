#!/bin/sh

source "`dirname "$0"`/config"

hostlist="`cat "$hostlistfile"`"

# Gather the data from stdin (that is the output from ./all.sh)
data="`cat`"

get_missing_hosts(){
  local tmpfile1="`mktemp --tmpdir cl-hosts-XXXXXXXX`"
  local tmpfile2="`mktemp --tmpdir cl-activehosts-XXXXXXXX`"
  echo "$hosts" > "$tmpfile1"
  echo "$active_hosts" > "$tmpfile2"
  echo "`diff -E -b -B -y --suppress-common-lines --left-column "$tmpfile1" \
      "$tmpfile2"`"
  rm "$tmpfile1" "$tmpfile2"
}


# Process the data
num_cores="`echo "$data" | num_cores.sh`"
num_procs="`echo "$data" | num_procs.sh`"
num_overcommits="`echo "$data" | num_overcommits.sh`"
num_free="`echo "$data" | num_free.sh`"
num_unniced="`echo "$data" | get_unniced.sh | wc -l`"
histogram="`echo "$data" | get_user.sh | histogram.py | sort`"

hosts="`echo "$hostlist" | sort -u`"
active_hosts="`echo "$data" | cut -d: -f1 | sort -u`"
missing_hosts="`get_missing_hosts`"
num_hosts="`echo "$hosts" | wc -l`"
num_active_hosts="`echo "$active_hosts" | wc -l`"
num_hosts_down=$(( $num_hosts - $num_active_hosts ))

echo "$histogram"
echo
echo "Number of hosts: $num_hosts"
echo "Number of active hosts: $num_active_hosts"
echo "Number of unavailable hosts: $num_hosts_down"
echo "$missing_hosts"
echo "Total number of cores: $num_cores"
echo "Total number of running jobs: $num_procs"
echo "Number of overcommitted jobs: $num_overcommits"
echo "Number of unniced jobs: $num_unniced"
echo "Number of free cores: $num_free"
