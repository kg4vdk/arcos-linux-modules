#!/bin/bash

wget -O /tmp/conditions.gif https://www.hamqsl.com/solar100sc.php?back=transparent

if ! file /tmp/conditions.gif | grep empty; then
	/usr/bin/convert /tmp/conditions.gif /tmp/conditions.png
	rm /tmp/conditions.gif
else
	rm /tmp/conditions.png
fi
