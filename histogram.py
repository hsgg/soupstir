#!/usr/bin/env python

import sys

dict = {}
total = 0.0
maxlen = 0

line = sys.stdin.readline()
while line:
    line = line.strip()
    try:
        dict[line] = dict[line] + 1
    except KeyError:
        dict.update({line: 1})
        maxlen = len(line) if len(line) > maxlen else maxlen
    total = total + 1.0
    line = sys.stdin.readline()

total = total / 100.0

for line in dict.keys():
    prt = "%-" + str(maxlen) + "s\t%s\t%s"
    print prt % (line, dict[line], dict[line] / total)

# vim: set sw=4 et sts=4 :
