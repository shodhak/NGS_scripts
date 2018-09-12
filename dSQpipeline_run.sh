#!/bin/bash

#SBATCH --array=0-299
#SBATCH --job-name=jobfile1.txt
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=shreyas.joshi@yale.edu
#SBATCH --ntasks=1

/ycga-gpfs/apps/hpc/software/dSQ/0.92/dSQBatch.py $1
