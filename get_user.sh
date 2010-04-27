#!/bin/sh

grep '^.*: R ' | tr -s ' ' | cut -d' ' -f 5-6
