#!/usr/bin/env python

import sys

delimiter = '\t'
fieldnum = 0

line = sys.stdin.readline()
while line:
    line = line.strip().split(delimiter)
    try:
        if line[0] != current:
            current = line[fieldnum]
            print("")
    except NameError:
        current = line[fieldnum]
    print(delimiter.join(line))
    line = sys.stdin.readline()

# vim: set sw=4 et sts=4 :
