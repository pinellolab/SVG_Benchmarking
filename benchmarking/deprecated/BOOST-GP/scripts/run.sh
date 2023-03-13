#!/usr/bin/bash

source ~/.bashrc
conda activate svg

start=$(date +'%s')

cd ../../utils

time Rscript run_boost_gp.R --input=$1 --output=$2 \

echo "It took $(($(date +'%s') - $start)) seconds"
