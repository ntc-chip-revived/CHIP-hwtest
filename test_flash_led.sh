#!/bin/bash

# call script to make light pulse. See also blink version
./flash_led.sh -p .4 &
PID="$!"


# Clean up on exit. Kill the flash process, and set light back to 1
finish() {
	kill $PID
	./flash_led.sh -s 1
	echo "DONE"
}
# In case of any exit, clean up
trap finish EXIT

# for test purposes, sleep for 5 seconds then exit
sleep 5
exit 0