#!/bin/bash

module load Python/miniconda
source activate test_ngs

module load StdEnv
module load SAMtools
module load BCFtools

#ref_genome = /home/sj577/Documents/ref_genome/pnref_genome.fasta 

#samtools faidx /home/sj577/Documents/test_ngs/ref_genome/pnref_genome.fasta 

cd /home/sj577/project/samfiles_isr/
#Compute the genometypes from bam alignment files through mpileup
samtools mpileup -f /home/sj577/Documents/test_ngs/ref_genome/pnref_genome.fasta  *.sorted.bam > isr_genotypes.vcf

#Convert vcf file to vcf.gz
#Load tabix module
module load tabix
#gzip the vcf file with bgzip command
bgzip isr_genotypes.vcf

#Call the variants from the genotypes
bcftools call --ploidy 1 -vm -Ov isr_genotypes.vcf.gz > isr_variants.vcf


