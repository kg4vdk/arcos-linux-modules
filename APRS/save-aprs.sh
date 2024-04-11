#!/bin/bash

cp -r $HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles/arcOS /tmp/aprs-profile

tar -C /tmp -czf aprs-profile_$(date +"%Y%m%d%H%M").tgz aprs-profile

rm -rf /tmp/aprs-profile
