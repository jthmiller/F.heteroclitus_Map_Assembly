#!/bin/sh

BT=/home/nreid/bin/bedtools/bin/bedtools2

zcat /home/jmiller1/16.4.18.MAP/scripts/site.depth.txt | awk '$3>450' | awk '{OFS="\t"}{print $1,$2-1,$2,$3}' | $BT merge -i stdin -d 10 -c 4 -o mean,max | awk '{OFS="\t"}{print $1,$2,$3,$4,$5,$3-$2}' | awk '$6>100' | awk '$5<2000' > /home/jmiller1/16.4.18.MAP/scripts/radsites.bed
