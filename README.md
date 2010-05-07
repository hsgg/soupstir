soupstir - See jobs on your cluster
===================================

'soupstir' is a collection of shell and python scripts to analyse the usage of
CPU time on a heterogeneous computer cluster. Other measures have also been
added, and more may come.

'soupstir' is short for for Simple Orchestra of Unix Process STatistical
Information Reapers.


Getting started
---------------

To use it, edit the file "config" in this directory making sure that the
'cfree' command is executable on every host, and pointing to the 'cfree.sh'
shell script included in this directory.

The hostlistfile must be a list of all hosts, one per line, as given to the
'slogin' command.

Then you can run

        ./all.sh | tee log | ./statistics.sh

to gather data. It executes '$cfree' on every host, saves it to the file
'log', and then displays statistics such as a histogram of how many jobs each
user is running, the number of unreachable hosts, the number of cores, and
the number of overcommitted and unniced jobs. The user 'freecores none' is a
placeholder for cores where no job is running on, so you can easily check that
by running

        cat log | grep "Number of free cores"

where I have reused the log file from before, but, of course, that could
also be replaced by './all.sh' to get fresh data.

See also the 'DESIGN' document, especially for troubleshooting.


What you need
-------------

The following requirements must be met on every node:
	- Remote login via slogin (part of ssh) without asking for a password
	  (like using a key)
	- /bin/sh
	- hostname
	- ps
	- grep
	- sed
	- wc
	- echo
So, basically a very, very standard UNIX-like OS.

On the host you want to analyse stuff, you additionally need:
	- python (probably <3)
	- slogin (symlink to ssh)
	- tr
	- cut
	- paste
	- bc
	- cat
	- dirname
	- rm
	- sort
	- diff
Apart from 'python' and perhaps 'diff' or 'slogin', I'd be very surprised if
you don't already have those.


What more?
----------

Please keep in mind that this software is still very early in its development,
I can't guarantee for anything.

In particular, the definition of a job may not fit your requirements. A job is
defined as a process or thread that lasts more than 59secs walltime, and gets
more than 10% CPU time averaged over its entire lifetime.
If you have a better way to determine what a job is, please speak up.

Greetings,
Henry


PS: If you must, you can email me at hsggebhardt@googlemail.com.
