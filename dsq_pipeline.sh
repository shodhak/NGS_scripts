#!/bin/bash

module load dSQ

#The code accepts the filename as an argument
echo $0
echo $1

#Submit the jobfile for dSQ run
dSQ.py --jobfile $1  > dSQpipeline_run.sh
