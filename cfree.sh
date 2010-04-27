#!/bin/sh

psrun(){
  ps H -eo state,c,stat,euser,egroup,comm
}

filter(){
  # filter for state Running, and a lot of %cpu (more than 50%)
  grep -e '^R [5-9][0-9]' -e '^R 100'
}


get_num_procs(){
  if [ x"$processes" = x"" ]; then
    echo "0"
  else
    echo "`echo "$processes" | wc -l`"
  fi
}


freedom(){
  if [ "$num_free" -lt "0" ]; then
    echo "WARNING: Too many active jobs!!!!"
  elif [ "$num_free" -gt "0" ]; then
    echo "Juhuuu!!!"
  fi
}


prefix="`hostname`"
processes="`psrun | filter`"
num_cpus="`cat /proc/cpuinfo | grep ^processor | wc -l`"
num_procs="`get_num_procs`"
num_free=$(( $num_cpus - $num_procs ))

processes="`echo "$processes" | sed "s/^/$prefix: /"`"

echo "$processes"
echo "$prefix: Number of cores: $num_cpus"
echo "$prefix: Number of procs: $num_procs"
echo "$prefix: Number of free cores: $num_free `freedom`"
