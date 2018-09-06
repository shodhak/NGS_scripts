#!/bin/bash

module load StdEnv
module load SAMtools

cd /home/sj577/project/samfiles_hun/

for seqfile in *.sam
do
        A="$(cut -d'.' -f1 <<< $seqfile)"
        echo $A
        samtools view -S -b $A.sam > $A.bam
	samtools sort $A.bam -o $A.sorted.bam
	samtools index $A.sorted.bam
done

#Copy the bam files from samfiles folder to bamfiles
cp *bam /home/sj577/project/bamfiles_hun/

#Copy the bam index files with the extension bai from samfiles folder to bamfiles
cp *bam.bai /home/sj577/project/bamfiles_hun/
