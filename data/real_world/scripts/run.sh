#!/bin/bash

### Job name
#SBATCH -J download
#SBATCH -e ./download.txt
#SBATCH -o ./download.txt

### Time your job needs to execute, e. g. 15 min 30 sec
#SBATCH -t 120:00:00

### Memory your job needs per node, e. g. 1 GB
#SBATCH --mem=30G -c 64

source ~/.bashrc
conda activate r-4.1

python download.py
