#!/bin/bash

#The script takes fastq filenames as arguments. Echo the filenames on the terminal and log file:
#Also echo the name of script in the begining:
echo $0
echo $1
echo $2

#Extract sample name from filename so that it can be used for output files
#Extract name of the file from the full path
filepath="$(cut -d'/' -f8 <<< $1)"
echo $filepath
A="$(cut -d'_' -f2 <<< $filepath)"
B="$(cut -d'_' -f3 <<< $filepath)"
echo ${A///}
echo ${B///}

#Combine A and B to make samplenames for the output files
samplename=${A///}_${B///}
echo $samplename

#The following code is for the complete pipeline. The complete workflow will consist of the following steps:
#Fastqc and Cutadapt through trim_galore (via miniconda)
#MultiQC for checking results for multiple files
#Bowtie2 for alignment
#Samtools for making bam files
#Tabix for making indexed gz files
#Bcftools for variant calling
#GATK/Annovar for annotation

#Call conda environment
module load Python/miniconda
source activate test_ngs

#TrimGalore 
trim_galore -q 30 --fastqc --paired -o /home/sj577/project/test_qcresults $1 $2

#Bowtie2
cd /home/sj577/project/test_qcresults 
bowtie2 -x /home/sj577/Documents/test_ngs/ref_genome/pnrefdb -1 *${A///}_*val_1*.fq.gz -2 *${A///}_*val_2*.fq.gz -S /home/sj577/project/test_samfiles/${samplename}.sam --no-unal 



