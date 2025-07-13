#!/bin/bash

wget -O /tmp/radar.gif https://radar.weather.gov/ridge/standard/XXXNWSSTATIONXXX_0.gif

if file /tmp/radar.gif | grep empty; then
	rm /tmp/radar.gif
fi
