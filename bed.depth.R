#!/bin/R

depth.bed <- read.table('unfiltered.bed',stringsAsFactors=F)
pdf('/home/jmiller1/16.4.18.MAP/scripts/TotalCoveragePerBaseinRefGenome.pdf')
hist(log(depth.bed$V3[which(depth.bed$V3>75)],base=10), breaks=15000, ylab='Locus Count', xlab='Read Depth (log10)', main='Total Coverage Per Base in Ref Genome (bases > 75)' , cex=1.75,cex.lab=1.75,cex.main=1.75)
abline(v=c(2.0,3.3), col='red')
dev.off()
