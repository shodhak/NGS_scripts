#!/bin/bash

for dir in /home/sj577/project/all_sequences/*/
	do
		#echo $dir
		echo "sh pipeline.sh $dir/Unaligned/*R1_001.fastq.gz $dir/Unaligned/*R2_001.fastq.gz" >> jobfile.txt
	done

#In HPC 300 cores are assigned for a single run.
#Make one job file with the first 300 lines

head -300 jobfile.txt > jobfile1.txt

#Count total number of lines in the jobfile
nlines=$(wc -l < jobfile.txt)
echo $nlines
#Number of lines left after the first 300
tlines=$((nlines-300))
echo $tlines
#Copy those lines into a new job file
tail -$tlines jobfile.txt > jobfile2.txt
