#!/bin/bash

#SBATCH --array=0-287
#SBATCH --job-name=jobfile.txt
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=shreyas.joshi@yale.edu
#SBATCH --ntasks=1

/ycga-gpfs/apps/hpc/software/dSQ/0.92/dSQBatch.py jobfile.txt
