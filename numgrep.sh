#!/bin/bash

field=1
delimiter=$'\x09'
minimum="0"
maximum="100"


TEMP=`getopt -o a:b:f:d: --long minimum:,maximum:,field:,delimiter: \
     -n "$0" -- "$@"`

if [ $? != 0 ] ; then
	echo "Usage: $0 [ -a minimum | -b maximum | -f field | -d delimiter ]"
	exit 1
fi

eval set -- "$TEMP"

while true ; do
	case "$1" in
		-a|--minimum)   minimum="$2" ;   shift 2 ;;
		-b|--maximum)   maximum="$2" ;   shift 2 ;;
		-f|--field)     field="$2" ;     shift 2 ;;
		-d|--delimiter) delimiter="$2" ; shift 2 ;;
		--) shift ; break ;;
		*) echo "Internal error!" ; exit 1 ;;
	esac
done

bin=$(/usr/bin/env python -c "print((float($maximum) + float($minimum)) / 2.0)")
size=$(/usr/bin/env python -c "print(float($maximum) - float($minimum))")

#echo min=$minimum
#echo max=$maximum
#echo bin=$bin
#echo size=$size
#echo field=$field
#echo delimiter=\"$delimiter\"

PATH="$PATH:`dirname $0`"

copycol.py -i"$field" -o1 -d"$delimiter" \
	| bin.py -b"$bin" -s"$size" -f1 -d"$delimiter" \
	| grep "^$bin$delimiter" \
	| cut -d"$delimiter" -f2-
