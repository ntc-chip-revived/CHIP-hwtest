#!/bin/bash

nanddump --bb=dumpbad -s 0x1FE000000 -l 0x400000 -f /dev/null /dev/mtd4 2>&1 | bbcheck.awk
