# NGS_analysis
Scripts for analyzing sequence data

Below is the list of scripts used in the paralelization of sequence analysis on the HPC:

pipeline.sh : NGS analysis pipeline that takes fastq.gz files as input (provided as arguments on the terminal) 
	TrimGalore: Sequence quality and adapter trimming
	Bowtie2: Alignment of sequence with the reference genome and generates sam output
	Samtools: convert sam to bam format followed by sorted bam files
	Samtools: mpileup to generate vcf files
	Tabix: To bgzip and index vcf files
	Bcftools: For variant calling from vcf files

Steps for parallelization on HPC:
1. lane_combine.sh: Check if any samples have sequences from multiple lanes. If yes, concatenate R1 and R2 reads.
2. make_joblist.sh: Generate job list text file that calls pipeline.sh on all the paired end sequences for upto 300 samples. If there are more than 300 samples, then the script generates two joblist files joblist1 and joblist2.
3. dsq_pipeline.sh: Generates dead simple queue run script from the provided joblist file in the argument. e.g.: dsq_pipeline.sh joblist1
4. sbatch dSQpipeline_run.sh: This runs the dead simple queue in which each line gets its own core to run the piepeline. So it is possible to run sequences from 300 samples in a single run. 
	
