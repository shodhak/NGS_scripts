#!/bin/bash

#Some of the sequence files (sequences from Israel with tag DMW in folders) have more than 2 sequences
#because they contain the data from two lanes
#Following code combines the sequences (cat all R1 together and all R2 together)

for dir in /home/sj577/project/all_sequences/*/
	do
		A="$(cut -d'/' -f6 <<< $dir)"
		cd $dir/Unaligned
		#Count the number of files in the directory
		nfiles=$(ls -l|wc -l)
		#echo ${A///}
		#echo ${nfiles}
		if test $nfiles -gt 3
		then
			echo ${A///}
			echo ${nfiles}
                	echo "combining file....."
			cat *R1*.fastq.gz > ${A///}_combined_L012_R1_001.fastq.gz
			cat *R2*.fastq.gz > ${A///}_combined_L012_R2_001.fastq.gz
			#Once combined, remove the previous original files
			rm *L00*.fastq.gz
			echo "files combined successfully. Moving on....."
		fi
	done 
