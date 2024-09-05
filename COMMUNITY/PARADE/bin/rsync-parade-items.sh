#!/bin/bash

mkdir -p /ARCOS-DATA/PARADE_DATA

rsync -avz /var/www/html/items /ARCOS-DATA/PARADE_DATA/
