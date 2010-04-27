#!/bin/sh

source "`dirname "$0"`/config"

hostlist="`cat "$hostlistfile"`"


if [ x"$1" = x"-q" ]; then
  # Ignore stderr
  exec 2>/dev/null
fi


for host in $hostlist; do
  # Use slogin instead of ssh, because some hosts have issues with ssh.
  ( slogin -x "$host" "$cfree" ) &
done

wait
