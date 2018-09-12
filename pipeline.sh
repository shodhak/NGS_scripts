#!/bin/bash

#Load stdenv module required for sequence analysis tools
module load StdEnv

#The script takes fastq filenames as arguments. Echo the filenames on the terminal and log file:
#Also echo the name of script in the begining:
echo $0
echo $1
echo $2

#Extract sample name from filename so that it can be used for output files
#Extract name of the file from the full path
filepath="$(cut -d'/' -f6 <<< $1)"
echo $filepath
A=$filepath
#A="$(cut -d'/' -f2 <<< $filepath)"
#B="$(cut -d'_' -f3 <<< $filepath)"
echo ${A///}
#echo ${B///}

#Combine A and B to make samplenames for the output files
samplename=${A///}
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
#load Bowtie2 module
module load Bowtie2
#Go to the folder containing quality and adapter trimmed sequences
cd /home/sj577/project/test_qcresults 
echo "Found folder with adapter and quallity trimmed sequences...."
echo "Started bowtie alignment...."
bowtie2 -x /home/sj577/Documents/test_ngs/ref_genome/pnrefdb -1 *${samplename}_*val_1*.fq.gz -2 *${samplename}_*val_2*.fq.gz -S /home/sj577/project/test_samfiles/${samplename}.sam --no-unal 

#Samtools for converting sam files to bam format
#load samtools module
module load SAMtools
#Go to the directory containing sam file
cd /home/sj577/project/test_samfiles
echo "Found folder with sam files....
echo "Started conversion from sam to bam....""
#convert samfiles to bam
samtools view -S -b ${samplename}.sam > ${samplename}.bam
#Make sorted bam files
samtools sort ${samplename}.bam -o ${samplename}.sorted.bam
#Index sorted bam files
samtools index ${samplename}.sorted.bam

echo "samtools run complete...."
echo "Copying files to bamfiles folder...."

#Copy the bam files from samfiles folder to bamfiles
cp ${samplename}.sorted.bam /home/sj577/project/test_bamfiles/

#Copy the bam index files with the extension bai from samfiles folder to bamfiles
cp ${samplename}.sorted.bam.bai /home/sj577/project/test_bamfiles/

echo "Transfer complete...."

#Make vcf file for the sample
samtools mpileup -f /home/sj577/Documents/test_ngs/ref_genome/pnref_genome.fasta $samplename}.sorted.bam > /home/sj577/project/test_vcf/${samplename}.vcf

echo "Pipeline run for sample ${samplename} completed successfully...."
