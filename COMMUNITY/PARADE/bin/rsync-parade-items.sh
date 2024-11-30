#!/bin/bash

mkdir -p /ARCOS-DATA/PARADE_DATA/items

rsync -avz --delete /var/www/html/items/ /ARCOS-DATA/PARADE_DATA/items
