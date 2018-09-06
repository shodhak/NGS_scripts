#!/bin/bash

module load Bowtie2

cd /home/sj577/project/trimmed_hun/

for seqfile in *R1*val_1*
do
  	#The following code takes the filename including the path as a string and splits it based on the "_"
        #the fifth element contains the name of the sample
        A="$(cut -d'_' -f3 <<< $seqfile)"
        B="$(cut -d'_' -f2 <<< $seqfile)"
        echo ${A///}
        echo ${B///}
        bowtie2 -x /home/sj577/Documents/test_ngs/ref_genome/pnrefdb -1 /home/sj577/project/trimmed_hun/*${A///}_*val_1* -2 /home/sj577/project/trimmed_hun/*${A///}_*val_2*.fq.gz -S /home/sj577/project/samfiles_hun/${B///}_${A///}.sam --no-unal
done
