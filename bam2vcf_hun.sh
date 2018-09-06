#!/bin/bash

module load Python/miniconda
source activate test_ngs

module load StdEnv
module load SAMtools
module load BCFtools

#ref_genome = /home/sj577/Documents/ref_genome/pnref_genome.fasta 

#samtools faidx /home/sj577/Documents/test_ngs/ref_genome/pnref_genome.fasta 

#cd /home/sj577/project/samfiles_hun/
#Compute the genometypes from bam alignment files through mpileup
#bcftools mpileup -f /home/sj577/Documents/test_ngs/ref_genome/pnref_genome.fasta  *.sorted.bam > hun_genotypes.vcf

#Call the variants from the genotypes
bcftools call --ploidy 1 -vm -Ov hun_genotypes.vcf.gz > hun_variants.vcf


