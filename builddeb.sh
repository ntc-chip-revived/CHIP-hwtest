#!/bin/bash

echo -e "\nIt looks like the last version built was 0."$(cat l_version)".."
echo -e "\nWould you like to increment it to 0."$((cat l_version)+1)"?"

#cd chip-hwtest*
#dpkg-buildpackage
