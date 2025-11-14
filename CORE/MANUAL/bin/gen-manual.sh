#!/bin/bash

if [ -f ../arcOS-Field-Manual.html ]; then
	rm ../arcOS-Field-Manual.html
fi

for md in ../markdown/*.md; do
	markdown --html4tags $md >> ../arcOS-Field-Manual.html
done
