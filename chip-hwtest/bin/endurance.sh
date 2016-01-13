#!/bin/sh

URL=https://s3-us-west-2.amazonaws.com/opensource.nextthing.co/chip/debian/next-gui/120/rootfs.ubi

function init() {
  START_DATE="$(date)"
  START_DATE_SECS="$(date +%s)"
}

function update() {
  CUR_DATE_SECS="$(date +%s)"
  DURATION=`date -u -d "0 ${CUR_DATE_SECS} sec - ${START_DATE_SECS} sec" +"%H:%M:%S"`
}

init

TESTS=( \
"dd if=/dev/zero of=/tmp/test bs=512 count=204800" \
"stress -t 300 -m 1" \
"ping -c 10 8.8.8.8" \
"wget ${URL} -O/tmp/download" \
)
TN=0

while true; do
  TN=$(expr $TN + 1)
  TN=$(expr $TN % ${#TESTS[@]} )
  update
  clear
  echo
  echo "     #  #  #                                   "
  echo "     #  #  #             Start: ${START_DATE}   Total: ${DURATION}"
  echo "   ###########                                 "
  echo "####         ####                              "
  echo "   #  OO     #                                 "
  echo "####  OO     ####                              "
  echo "   #    OOO  #                                 "
  echo "####         ####                              "
  echo "   ###########                                 "
  echo "     #  #  #                                   "
  echo "     #  #  #                                   "
  echo
  echo " Running: ${TESTS[$TN]}"
  #echo -e -n "\033[13A"

  ${TESTS[$TN]} 
 
  sleep 1
done
