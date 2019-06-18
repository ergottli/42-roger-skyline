#!/bin/bash

FILE="/etc/crontab"
CHECKSOURCE="/home/ergottli/scripts/checksource"

if [ ! -f "$CHECKSOURCE" ]
then
	touch $CHECKSOURCE
	md5sum $FILE > $CHECKSOURCE
fi

CHECK=$(md5sum "$FILE")
CHECKPREV=$(cat "$CHECKSOURCE")

if [ "$CHECK" = "$CHECKPREV" ]
then
	echo "$CHECK" > "$CHECKSOURCE"
else
	sendmail root < /home/ergottli/scripts/email.txt
	echo "$CHECK" > "$CHECKSOURCE"
fi
