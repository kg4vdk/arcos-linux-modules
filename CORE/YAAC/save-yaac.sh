#!/bin/bash

if [ -d yaac-profile ]; then
	mv yaac-profile yaac-profile_$(date +"%Y%m%d%H%M%Z")
	cp -r $HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles/arcOS ./yaac-profile
else
	cp -r $HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles/arcOS ./yaac-profile
fi
