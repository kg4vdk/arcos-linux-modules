#!/bin/bash

if [ -f WSJT-X.ini ]; then
	mv WSJT-X.ini WSJT-X_$(date +"%Y%m%d%H%M%Z").ini
	cp $HOME/.config/WSJT-X.ini WSJT-X.ini
else
	cp $HOME/.config/WSJT-X.ini WSJT-X.ini
fi
