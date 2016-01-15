#!/bin/bash

echo nanddump --bb=dumpbad -s 0x1FEC00000 -l 0x400000 -f /tmp/dump1FEC /dev/mtd4
nanddump --bb=dumpbad -s 0x1FEC00000 -l 0x400000 -f /tmp/dump1FEC /dev/mtd4
echo nanddump --bb=dumpbad -s 0x1FE800000 -l 0x400000 -f /tmp/dump1FE8 /dev/mtd4
nanddump --bb=dumpbad -s 0x1FE800000 -l 0x400000 -f /tmp/dump1FE8 /dev/mtd4
echo nanddump --bb=dumpbad -s 0x1FE400000 -l 0x400000 -f /tmp/dump1FE4 /dev/mtd4
nanddump --bb=dumpbad -s 0x1FE400000 -l 0x400000 -f /tmp/dump1FE4 /dev/mtd4
echo nanddump --bb=dumpbad -s 0x1FE000000 -l 0x400000 -f /tmp/dump1FE0 /dev/mtd4
nanddump --bb=dumpbad -s 0x1FE000000 -l 0x400000 -f /tmp/dump1FE0 /dev/mtd4

md5sum /tmp/dump1FEC /tmp/dump1FE8 /tmp/dump1FE4 /tmp/dump1FE0
