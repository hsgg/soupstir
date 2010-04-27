#!/bin/sh

grep "Number of cores" | cut -d: -f3 | paste -sd+ | bc
