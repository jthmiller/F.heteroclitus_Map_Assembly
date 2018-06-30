#!/bin/bash -l

module load perlnew/5.18.4
module load stacks/1.31 

# execute using sbatch -c 24 Process_radtags.sh
# Example for paired end data
# process_radtags -P -p ./raw/ -o ./samples/ \ -b ./barcodes/barcodes_lane4 \ -e sbfI -E phred33 -r -c -q

#Library 2.1
#process_radtags -P -p /home/jmiller1/Jeffrey/Meiotic/Project_Whitehead/Sample_JMAW001 -o /home/jmiller1/16.4.18.MAP/process_radtags/RUN2.1 -b /home/jmiller1/Jeffrey/Meiotic/barcodes/BARCODES_96_C1.txt -e sbfI -E phred33 -c -q -i gzfastq

#Library 2.2
process_radtags -P -p /home/jmiller1/Jeffrey/Meiotic/140604_HS1A/Project_Miller/Sample_AWJM002_NebNEXT14 -o /home/jmiller1/16.4.18.MAP/process_radtags/RUN2.2 -b /home/jmiller1/Jeffrey/Meiotic/barcodes/BARCODES_96_C1.txt -e sbfI -E phred33 -c -q -i gzfastq 

