#!/bin/bash

mkdir -p /media/$USER/ARCOS-DATA/PARADE_DATA

date=$(date +"%FT%H%M")

echo "ID,ORGANIZATION,CONTACT,PHONE,VEHICLES,TRAILERS,WALKERS,NOTES" > /media/$USER/ARCOS-DATA/PARADE_DATA/parade_$date.csv

for i in $(find /var/www/html/items -type f ! -path '*/deleted/*' | sort); do

	id=$(head -n 1 $i)
    organization=$(head -n 2 $i | tail -n 1)
    contact=$(head -n 3 $i | tail -n 1)
    phone=$(head -n 4 $i | tail -n 1)
    vehicles=$(head -n 5 $i | tail -n 1)
    trailers=$(head -n 6 $i | tail -n 1)
    walkers=$(head -n 7 $i | tail -n 1)
    notes=$(head -n 8 $i | tail -n 1)    
	echo "$id,\"$organization\",\"$contact\",$phone,$vehicles,$trailers,$walkers,\"$notes\"" >> /media/$USER/ARCOS-DATA/PARADE_DATA/parade_$date.csv
done

ln -s /media/$USER/ARCOS-DATA/PARADE_DATA/parade_$date.csv $HOME/.nbems/FLAMP/parade_$date.csv

ln -s /media/$USER/ARCOS-DATA/PARADE_DATA/parade_$date.csv $HOME/Desktop/parade_$date.csv

notify-send --icon=text-csv "CSV file generated..." "File is ready for transmission by FLAMP."
