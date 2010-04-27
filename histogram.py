#!/usr/bin/env python

import sys

dict = {}

total = 0.0

line = sys.stdin.readline()
while line:
    line = line.strip()
    try:
        dict[line] = dict[line] + 1
    except KeyError:
        dict.update({line: 1})
    total = total + 1.0
    line = sys.stdin.readline()

total = total / 100.0

for line in dict.keys():
    print line, "\t", dict[line], "\t", dict[line] / total
