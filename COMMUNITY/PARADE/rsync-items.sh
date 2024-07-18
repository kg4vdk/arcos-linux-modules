#!/bin/bash

mkdir -p /media/user/ARCOS-DATA/PARADE

rsync -avz /var/www/html/items /media/user/ARCOS-DATA/PARADE/
