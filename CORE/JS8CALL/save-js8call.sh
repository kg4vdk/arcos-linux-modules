#!/bin/bash

if [ -f JS8Call.ini ]; then
	mv JS8Call.ini JS8Call_$(date +"%Y%m%d%H%M%Z").ini
	cp $HOME/.config/JS8Call.ini JS8Call.ini
else
	cp $HOME/.config/JS8Call.ini JS8Call.ini
fi
