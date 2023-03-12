#!/bin/bash

### Job name
#SBATCH -J analysis
#SBATCH -e ./analysis.txt
#SBATCH -o ./analysis.txt

### Time your job needs to execute, e. g. 15 min 30 sec
#SBATCH -t 120:00:00

### Memory your job needs per node, e. g. 1 GB
#SBATCH --mem=360G -c 64

source ~/.bashrc
conda activate svg

jupyter nbconvert --to html --execute ./01_simulate_svgs.ipynb --output-dir ./viz
jupyter nbconvert --to html --execute ./02_simulate_refs.ipynb --output-dir ./viz
