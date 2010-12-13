#!/usr/bin/env python

from __future__ import print_function
import sys, math, getopt

# Nonpositive should mean from end of list.
# outfield = 0 means that we should append to the end of the list,
# outfield = 1 means to insert at the beginning, and
# outfield = -1 means to insert before the last element in the list.
# So the default is to append, and everything else is basically the difference
# to that.
infield = 1
outfield = 0

delimiter = '\t'

try:
    opts, args = getopt.getopt(sys.argv[1:], "i:o:d:", ["infield=",
        "outfield=", "delimiter="])
except getopt.GetoptError:
    sys.stderr.write("Usage: " + sys.argv[0]
            + " [-i infield | -o outfield | -d delimiter]\n")
    sys.exit(2)
for opt, arg in opts:
    if opt in ("-i", "--infield"):
        infield = int(arg)
    elif opt in ("-o", "--outfield"):
        outfield = int(arg)
    elif opt in ("-d", "--delimiter"):
        delimiter = arg

infield = infield - 1
outfield = outfield - 1

for line in sys.stdin:
    line = line.strip().split(delimiter)
    if outfield < 0:
        of = outfield + len(line) + 1
    else:
        of = outfield
    line.insert(of, line[infield])
    print(delimiter.join(line))

# vim: set sw=4 et sts=4 :
