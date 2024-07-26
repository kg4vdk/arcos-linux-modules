#!/bin/bash

mkdir -p /media/user/ARCOS-DATA/PARADE_DATA

rsync -avz /var/www/html/items /media/user/ARCOS-DATA/PARADE_DATA/
