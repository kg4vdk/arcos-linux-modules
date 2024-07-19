#!/bin/bash

jq '."custom-format"."value" = "%a, %e %b%n%H:%M:%S %Z"' ~/.config/cinnamon/spices/calendar@cinnamon.org/13.json > /tmp/13.json && mv /tmp/13.json ~/.config/cinnamon/spices/calendar@cinnamon.org/13.json
