#!/bin/sh

#The following code performs quality checks and trimming on the sequences from Israel data
#Load the miniconda module and activate the environment test_ngs in which multiqc and trim galore has been installed
module load Python/miniconda
source activate test_ngs
#Load StdEnv for java (fastqc and cutadapt both require Java)
module load StdEnv
#Load trim_galore that is a wrapper for both fastqc and cutadapt
module load trim_galore


for dir in /home/sj577/project/isr_seqs/*/
do
        echo "$dir"
        A="$(cut -d'/' -f6 <<< $dir)"
	echo ${A///}
	echo ${A///}_combined_L012_R1_001.fastq.gz
	echo ${A///}_combined_L012_R2_001.fastq.gz
	trim_galore -q 30 --fastqc --paired -o /home/sj577/project/qcresults_isr /home/sj577/project/isr_catseqs/${A///}_combined_L012_R1_001.fastq.gz /home/sj577/project/isr_catseqs/${A///}_combined_L012_R2_001.fastq.gz	
done
