#!/usr/bin/env python

import sys, subprocess, os, string, glob, re

# Set PATH to where this script is
we = re.sub(r'(.*)/[^/]*$', r'\1', sys.argv[0])
if we[0] != '/':
    we = os.getcwd() + '/' + we
os.environ['PATH'] = os.environ['PATH'] + ":" + we

# Get filenames
filenames = glob.glob('/home/gebhardt/cluster/logs/log-*')
filenames.sort()


allusers = []

for file in filenames:
    time = re.sub('^.*log-', '', file)
    cmd="get_user.sh <'" + file + "' | histogram.py"
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout
    line = p.readline().rstrip()
    userok = []
    while line:
        [user, nproc, pproc] = line.split('\t')
        try:
            allusers.index(user)
        except:
            allusers.append(user)
        userok.append(user)
        print(user + "\t" + time + "\t" + nproc + "\t" + pproc)
        line = p.readline().rstrip()
    # users not active at this time get a 0
    for user in allusers:
        try:
            userok.index(user)
        except:
            print(user + "\t" + time + "\t0\t0.0")

# vim: set sw=4 et sts=4 :
