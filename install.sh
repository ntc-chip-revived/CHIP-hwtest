#!/bin/bash

SRC_DIR=$
sudo cp hwtest.sh /usr/bin/hwtest
sudo cp power.sh /usr/bin/
sudo cp battery.sh /usr/bin/
sudo mkdir -p /usr/lib/hwtest
sudo cp *.txt /usr/lib/hwtest

if [[ "$(cat /etc/os-release |grep ID_LIKE)" == "ID_LIKE=debian" ]];
then
  sudo apt-get install stress
fi
