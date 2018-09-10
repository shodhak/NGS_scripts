#!/bin/bash

for dir in /home/sj577/project/hun_seqs/*/
	do
		echo $dir
		echo "pipeline.sh $dir/Unaligned/*R1_001.fastq.gz $dir/Unaligned/*R2_001.fastq.gz" >> jobfile.txt
	done
