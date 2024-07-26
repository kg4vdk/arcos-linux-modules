#!/bin/bash

TIMESTAMP=$(date +%s)

LOG_PATH=/media/user/ARCOS-DATA/CHALLENGE_DATA/$TTCALL

mkdir -p $LOG_PATH

if [ ! -f $LOG_PATH/$TTCALL.log ]; then
	touch $LOG_PATH/$TTCALL.log
elif [ $(wc -l $LOG_PATH/$TTCALL.log | awk -F " " '{print $1}') = 3 ]; then
	OLD_TIMESTAMP=$(date -d "@$(head -n 1 $LOG_PATH/$TTCALL.log)" +"%Y%m%dT%H%M")
	mv $LOG_PATH/$TTCALL.log $LOG_PATH/$TTCALL-$OLD_TIMESTAMP.log
	touch $LOG_PATH/$TTCALL.log
fi

if [ "${TTCOMMENT}" = "Checked-In" ]; then
	if [ $(wc -l $LOG_PATH/$TTCALL.log | awk -F " " '{print $1}') = 0 ]; then
		echo "$TIMESTAMP" >> $LOG_PATH/$TTCALL.log
		TTCOMMENT="Checked in. Welcome to the Challenge Course. Please proceed to the first objective."
	else
		TTCOMMENT="Station already checked in."
	fi
fi

if [ "${TTCOMMENT}" = "Checked-Out" ]; then
	if [ $(wc -l $LOG_PATH/$TTCALL.log | awk -F " " '{print $1}') = 1 ]; then
		echo "$TIMESTAMP" >> $LOG_PATH/$TTCALL.log

		START_TIME=$(head -n 1 $LOG_PATH/$TTCALL.log)
		END_TIME=$(tail -n 1 $LOG_PATH/$TTCALL.log)
		ELAPSED_TIME=$(echo $((END_TIME - $START_TIME)))
		HOURS=$((ELAPSED_TIME / 3600))
		MINUTES=$(((ELAPSED_TIME / 60) % 60))
		SECONDS=$((ELAPSED_TIME % 60))

		echo "$HOURS hours, $MINUTES minutes, $SECONDS seconds" >> $LOG_PATH/$TTCALL.log

		TTCOMMENT="Checked out. Challenge Course Completed in $HOURS hours, $MINUTES minutes, $SECONDS seconds."
	else
		TTCOMMENT="Unable to check out. Station not checked in."
	fi
fi

# Convert callsign to NATO phonetics
TTCALL=$(/opt/arcOS/bin/call2nato.sh $TTCALL | sed 's/ /, /g')

echo "${TTCALL}, ${TTCOMMENT}"


