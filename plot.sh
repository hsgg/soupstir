#!/bin/sh

source "`dirname "$0"`/config"

sort | datasplit.py | cut -f3 | graph -a -TX
