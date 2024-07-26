#!/bin/bash

CALLSIGN=$(echo $1 | tr '[:lower:]' '[:upper:]')

LOG_PATH=/media/user/ARCOS-DATA/CHALLENGE_DATA/$CALLSIGN

for log in $LOG_PATH/*.log; do
	echo -n "$(echo "$log" | awk -F "/" '{print $7}') - "
	tail -n 1 $log
done
