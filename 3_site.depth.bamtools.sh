#!/bin/bash -l

my_bamtools=/home/jmiller1/bin/bamtools-master/bin/bamtools
my_samtools=/home/jmiller1/bin/samtools-1.3/samtools

$my_bamtools merge -list /home/jmiller1/16.4.18.MAP/scripts/bam.list | $my_bamtools filter -in stdin -mapQuality ">30" -isProperPair true | $my_samtools depth -d 200000 /dev/stdin | gzip -c > /home/jmiller1/16.4.18.MAP/scripts/site.depth.txt


