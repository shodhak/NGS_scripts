#!/bin/bash

for dir in /home/sj577/project/all_sequences/*
	do
		#echo $dir
		echo "sh pipeline.sh $dir/Unaligned/*R1*.fastq.gz $dir/Unaligned/*R2*.fastq.gz" >> jobfile.txt
	done

#Count total number of lines in the jobfile
nlines=$(wc -l < jobfile.txt)
echo $nlines

#In HPC 300 cores are assigned for a single run.
#Check if the primary jobfile has more or less than 300 lines
if test $nlines -gt 300
	then
		echo "The folder thas more than 300 samples. Making a jobfile for first 300 sequences."
		head -300 jobfile.txt > jobfile1.txt
		#Number of lines left after the first 300
		tlines=$((nlines-300))
		echo "Making another jobfile for remaining $tlines samples"
		#Copy those lines into a new job file
		tail -$tlines jobfile.txt > jobfile2.txt
fi
