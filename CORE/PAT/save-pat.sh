#!/bin/bash

if [ -f config.json ]; then
	mv config.json  config.json _$(date +"%Y%m%d%H%M%Z").json
	cp $HOME/.config/pat/config.json ./config.json 
else
	cp $HOME/.config/pat/config.json ./config.json
fi

