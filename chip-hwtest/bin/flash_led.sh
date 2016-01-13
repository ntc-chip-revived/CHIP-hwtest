#!/bin/bash
# This script will flash the LED
# Usage: ./flash_led.sh -option <args> &
# Requires root privileges

# Set state of LED
# @param 1 for on, 0 for off
set_light() {
	i2cset -f -y 0 0x34 0x93 $1
}

# Get state of LED
get_light() {
	i2cget -f -y 0 0x34 0x93
}

# Toggle the state of the LED next to the power LED
# If it's on, it goes off, and vice versa
toggle_light() {
	light=$(( `get_light` ))
	new_light="0x00"
	if [ $light == 0 ]; then
		new_light="0x01"
	fi
	set_light $new_light
}

# Endless loop to blink the LED on and off regularly
# @param wait = time to pause between each state change
pulse_loop() {
	while :
	do
		toggle_light
		sleep $1
	done
}
# Blink the light using different values for on and off times
# @param1 how long to stay on for
# @param2 how long to stay of for
blink_loop() {
	while :
	do
		set_light 1
		sleep $1
		set_light 0
		sleep $2
	done
}
#main 
# Go through options. In reality there should just be one
# In theory, we could add more for thinks like how long
# to loop for
while [ $# -gt 0 ]; do
	case "$1" in
	-p|--pulse)	
		pulse_loop "$2"
		shift; shift;
		;;
	-b|--blink)	
		blink_loop "$2" "$3"
		shift; shift; shift;
		;;
	-s|--set)	set_light "$2"
		shift;shift;
		;;
	-h|"-?"|--help)	echo "Usage: $0 [-b timeOn timeOff] [-p pulseTime] [-s 1|0]"
		exit 0;;
	esac
done

