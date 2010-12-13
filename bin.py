#!/usr/bin/env python

from __future__ import print_function
import sys, math, getopt

# 'size' specifies the width of a bin
# 'bin' is the midpoint of a bin
size = 100.0
bin = 0.0

field = 0
delimiter = '\t'

try:
    opts, args = getopt.getopt(sys.argv[1:], "b:s:f:d:", ["bin=", "size=",
	    "field=", "delimiter="])
except getopt.GetoptError:
    sys.stderr.write("Usage: " + sys.argv[0]
            + " [-b bin | -s size | -f field | -d delimiter]\n")
    sys.exit(2)
for opt, arg in opts:
    if opt in ("-b", "--bin"):
        bin = float(arg)
    elif opt in ("-s", "--size"):
        size = float(arg)
    elif opt in ("-f", "--field"):
        field = int(arg) - 1
    elif opt in ("-d", "--delimiter"):
        delimiter = arg


inoffset = bin - size * (math.floor(bin / size) + 0.5)
outoffset = bin - size * math.floor(bin / size)
#print(bin, size, field, delimiter, inoffset, outoffset)
#sys.exit(1)

for line in sys.stdin:
    line = line.strip().split(delimiter)
    value = float(line[field])
    line[field] = str(math.floor((value - inoffset) / size) * size + outoffset)
    print(delimiter.join(line))

# vim: set sw=4 et sts=4 :
