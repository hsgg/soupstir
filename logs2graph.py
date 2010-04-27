#!/usr/bin/env python

import subprocess
import os
import string
import glob
import re

os.environ['PATH'] = os.environ['PATH'] + ":" + "/home/gebhardt/cluster"

filenames = glob.glob('/home/gebhardt/cluster/logs/log-*')
filenames.sort()

outdir = '/home/gebhardt/cluster/graphs'
plotfile =  '/home/gebhardt/cluster/graphs/plot.gplt'

udat = {}

for file in filenames:
    print(file)
    cmd="cat '" + file + "' | get_user.sh | histogram.py | sort"
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout
    line = p.readline().rstrip()
    userok = []
    while line:
        thisdat = line.split('\t')
        time = re.sub('^.*log-', '', file)
        userok.append(thisdat[0])
        plotline = [time, thisdat[1], thisdat[2]]
        try:
            udat[thisdat[0]].append(plotline)
        except KeyError:
            udat.update({thisdat[0] : [plotline]})
        line = p.readline().rstrip()
    # users not active at this time get a 0
    for user in udat.keys():
        try:
            userok.index(user)
        except:
            plotline = [time, 0, 0.0]
            udat[user].append(plotline)


if (os.path.exists(outdir) == False):
    os.mkdir(outdir)
gpltline = "plot "
gpltsep = ""
for user in udat.keys():
    file = outdir + "/" + user + ".dat"
    print("Creating file '" + file + "'")
    gpltline = gpltline + gpltsep + '"' + file + '" using 3:xticlabels(1) w l'
    gpltsep = ","
    f = open(file, "w")
    for plotline in udat[user]:
        line = plotline[0] + "\t" + str(plotline[1]) + "\t" + str(plotline[2])
        f.write(line + "\n")
    f.close()
gpltfile = open(plotfile, "w")
gpltfile.write("set key off\n")
gpltfile.write("set xtics rotate by -90\n")
gpltfile.write(gpltline)
gpltfile.close()
print("Run gnuplot -persist " + plotfile + " to see the statistics")
