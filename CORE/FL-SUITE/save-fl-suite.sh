#!/bin/bash

if [ -f fl-suite.tgz ]; then
	mv fl-suite.tgz fl-suite_$(date +"%Y%m%d%H%M%Z").tgz
	tar -C $HOME -czf fl-suite.tgz .fldigi .nbems
else
	tar -C $HOME -czf fl-suite.tgz .fldigi .nbems
fi
