#!/bin/sh

grep "^.*: R " | tr -s " " | cut -d' ' -f7
