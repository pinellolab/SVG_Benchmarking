#!/bin/bash

### Job name
#SBATCH -J Sepal
#SBATCH -e ./Sepal.txt
#SBATCH -o ./Sepal.txt

### Time your job needs to execute, e. g. 15 min 30 sec
#SBATCH -t 120:00:00

### Memory your job needs per node, e. g. 1 GB
#SBATCH --mem=360G -c 64

source ~/.bashrc
conda activate r-4.1

jupyter nbconvert --to html --execute ./01_Sepal_simulate_SVGs.ipynb --output-dir ./viz

