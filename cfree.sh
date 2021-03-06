#!/bin/sh

psrun(){
  ps H -eo s=,c=,stat=,euser:10=,egroup=,comm=,etime=
}

filter(){
  # Filter for a lot of %cpu (more than 10%).
  # If we were to check for 50% or more, it would be possible but
  # difficult to find overcommits.
  # Also, ignore processes that don't have more than a minute of wall
  # time, like this very process itself, for instance.
  grep -e '^.  [1-9] ' -e '^. [1-9][0-9] ' -e '^. 100 ' | grep -v ' 00:..$'
}

jobs_only(){
  grep -e '^R [1-9][0-9] ' -e '^R 100 '
}


get_num_procs(){
  local themjobs="`echo "$processes" | jobs_only`"
  if [ x"$themjobs" = x"" ]; then
    echo "0"
  else
    echo "`echo "$themjobs" | wc -l`"
  fi
}


freedom(){
  if [ "$num_free" -lt "0" ]; then
    echo "WARNING: Too many active jobs!!!!"
  elif [ "$num_free" -gt "0" ]; then
    echo "Juhuuu!!!"
  fi
}

list_idle_procs(){
  local i=$num_free
  while [ "$i" -gt "0" ]; do
    # Emulate a "ps" line
    echo "$prefix: R 00 RN   freecores  none     idle               00:00"
    i=$(( $i - 1 ))
  done
}



prefix="`hostname`"
processes="`psrun | filter`"
num_cpus="`grep ^processor /proc/cpuinfo | wc -l`"
num_procs="`get_num_procs`"
num_free=$(( $num_cpus - $num_procs ))

# Prefix each line of output with $prefix
processes="`echo "$processes" | sed "s/^/$prefix: /"`"

echo "$processes"
list_idle_procs
echo "$prefix: Number of cores: $num_cpus"
echo "$prefix: Number of procs: $num_procs"
echo "$prefix: Number of free cores: $num_free `freedom`"
echo "$prefix: Load: `uptime`"
echo "$prefix: OS: `uname -s -r -m -o`"
