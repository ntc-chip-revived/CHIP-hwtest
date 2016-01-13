#!/bin/sh

for i in `seq 1 10`; do bitflipcheck.sh; done | nand_test.awk

