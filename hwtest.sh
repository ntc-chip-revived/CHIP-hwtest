#!/bin/sh

echo "############################################################"
echo "# [ CHIP HW TEST ]                                         #"
echo "############################################################"

if [[ -e log.txt ]]; then rm log.txt; fi

echo -e "\n"

echo -n -e "# Hardware list..."
if lshw -disable usb -disable scsi |grep -v size|grep -v serial| grep -v physical |grep -v configuration| diff - /usr/lib/hwtest/lshw_ref.txt >>log.txt; then
	echo "# Hardware list...OK";
else
	echo "# Hardware list...ERROR";
fi

echo -e -n "# I2C bus 0..."
if i2cdetect -y 0 |diff - /usr/lib/hwtest/i2cdetect_ref0.txt >>log.txt; then
	echo "OK"
else
	echo "ERROR"
fi

echo -e -n "# I2C bus 1..."
if i2cdetect -y 1 |diff - /usr/lib/hwtest/i2cdetect_ref1.txt >>log.txt; then
	echo "OK"
else
	echo "ERROR"
fi

echo -e -n "# I2C bus 2..."
if i2cdetect -y 2 |diff - /usr/lib/hwtest/i2cdetect_ref2.txt >>log.txt; then
	echo "OK"
else
	echo "ERROR"
fi

echo -n -e "# testing AXP209 on I2C bus 0..."
if dmesg |grep axp |sed -e 's/\[.*\]//' |diff - /usr/lib/hwtest/axp_ref.txt >>log.txt; then
	echo "OK"
else
	echo "ERROR"
fi
#./battery.sh
#./power.sh

echo -e -n "# GPIO expander test..."
if [[ "$(cat /sys/bus/i2c/devices/i2c-2/2-0038/name)" -eq "pcf8574a" ]]; then
	echo "OK"
else
	echo "ERROR"
fi


echo -e -n "# testing NAND write speed 1K block size..."
if dd if=/dev/zero of=/NAND_write_speed bs=1k count=256k 2>&1 |sed -e 's/,.*//g' |diff - /usr/lib/hwtest/dd_ref0.txt >>log.txt; then
	echo "OK"
else
	echo "ERROR"
fi

echo -e -n "# testing NAND write speed 16K block size..."
if dd if=/dev/zero of=/NAND_write_speed bs=16k count=16k 2>&1 |sed -e 's/,.*//g' |diff - /usr/lib/hwtest/dd_ref1.txt >>log.txt; then
	echo "OK"
else
	echo "ERROR"
fi

#if [[ -b /dev/sda ]];
#then
#  echo -e "\n * USB device /dev/sda found - type yes to *DESTROY* it's contents"
#  read confirmation
#  if [[ "${confirmation}" == "yes" ]]; 
#  then
#    echo -e "\n * testing USB write speed 1K block size"
#    dd if=/dev/zero of=/dev/sda bs=1k count=256k
#    echo -e "\n * testing USB write speed 4K block size"
#    dd if=/dev/zero of=/dev/sda bs=4k count=64k
#  fi
#fi

echo -n -e "# Doing 10s stress test..."
if stress -q --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 10s; then
	echo "OK"
else
	echo "ERROR"
fi

echo -e -n "# Wifi enumeration test..."
if iw dev|grep -v addr |grep -v ssid |diff - /usr/lib/hwtest/wifi_ref0.txt >>log.txt; then
	echo "OK"
else
	echo "ERROR"
fi

echo -e -n "# Searching for mobile hotspot..."
if iw dev wlan0 scan |grep -q "        SSID: NTC 4G OMG"; then
	echo "OK"
else
	echo "ERROR"
fi

