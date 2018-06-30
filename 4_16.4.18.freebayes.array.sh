#!/bin/bash -l
#SBATCH -J array_job
#SBATCH -o array_job_out_%A_%a.txt
#SBATCH -e array_job_err_%A_%a.txt
#SBATCH --array=1-10180
#SBATCH -p hi
#SBATCH --mem=10000
###### number of nodes
###### number of processors
#SBATCH --cpus-per-task=4
 
bwagenind=/home/nreid/popgen/kfish3/killifish20130322asm.fa
my_freebayes=/home/jmiller1/bin/freebayes/bin/freebayes
my_bedtools=/home/jmiller1/bin/bedtools2/bin/bedtools
my_bamtools=/home/jmiller1/bin/bamtools-master/bin/bamtools

scafnum=$(expr $SLURM_ARRAY_TASK_ID + -1)
scaf=Scaffold$scafnum
endpos=$(expr $(grep -P "$scaf\t" /home/nreid/popgen/kfish3/killifish20130322asm.fa.fai | cut -f 2) - 1)

region=$scaf:1..$endpos
echo $region

outfile=$scaf.vcf

# bam_dir=/home/jmiller1/QTL_Map_Raw/align
vcf_out=/home/jmiller1/16.4.18.MAP/vcf/scafvcfs/
bam_list=/home/jmiller1/16.4.18.MAP/scripts/bam.list
bed_regions=/home/jmiller1/16.4.18.MAP/scripts/radsites.bed

$my_bamtools merge -list $bam_list -region $region| \
$my_bamtools filter -in stdin -mapQuality '>30' -isProperPair true | \
$my_bedtools intersect -a stdin -b $bed_regions | \
$my_freebayes -f $bwagenind --use-best-n-alleles 4 --pooled-discrete --stdin > $vcf_out/$outfile

