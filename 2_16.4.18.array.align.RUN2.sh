#!/bin/bash -l
#SBATCH -J array_job
#SBATCH -o array_job_out_%A_%a.txt
#SBATCH -e array_job_err_%A_%a.txt
#SBATCH --array=1-96
#SBATCH -p hi
#SBATCH --mem=30000
#SBATCH --cpus-per-task=6
###### number of nodes
###### number of processors
####SBATCH -n 1

indir=/home/jmiller1/16.4.18.MAP/process_radtags/RUN2.2/
my_samtools=/home/jmiller1/bin/samtools-1.3/samtools
my_bwa=/home/jmiller1/bin/bwa-0.7.12/bwa
my_samblstr=/home/jmiller1/bin/samblaster-master/samblaster
bwagenind=/home/nreid/popgen/kfish3/killifish20130322asm.fa
outdir=/home/jmiller1/16.4.18.MAP/alignment/RUN2.2.bams
bcode=/home/jmiller1/16.4.18.MAP/scripts/BARCODES_96_C3.txt


fq1=$(find $indir -name "sample_*1.fq.gz" | grep -v 'rem\..\.fq' | sed -n $(echo $SLURM_ARRAY_TASK_ID)p)
fq2=$(echo $fq1 | sed 's/\.1\.fq/\.2\.fq/')
root=$(echo $fq1 | sed 's/.*sample_//' | sed 's/\..*//')
name=$(grep $root $bcode | cut -f 3)
rg=$(echo \@RG\\tID:$name\_$root\\tPL:Illumina\\tPU:x\\tLB:2.1\\tSM:$name\_$root)
tempsort=$root.temp\_$SLURM_JOB_ID
outfile=$outdir/$name\_$root.bam

echo $root
echo $fq1
echo $fq2
echo $rg
echo $tempsort
echo $outfile
echo $name

$my_bwa mem $bwagenind -t 6 -R $rg <(zcat $fq1 | sed 's/_[0-9]$//') <(zcat $fq2 | sed 's/_[0-9]$//') | $my_samblstr | $my_samtools view -S -h -u - | $my_samtools sort - -T /scratch/$tempsort -O bam -o $outfile
