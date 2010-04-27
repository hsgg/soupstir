#!/bin/sh

tr -s ' ' | grep "^.*: R " | grep -v "^.*: R [0-9]* RN"
