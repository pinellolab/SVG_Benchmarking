#!/usr/bin/bash

source ~/.bashrc
conda activate svg

start=$(date +'%s')

cd ../../utils

if [ "$1" = "BOOST-GP" ]; then
    time Rscript run_boost_gp.R --input=$2 --output=$3
elif [ "$1" = "SPARK" ]; then
    time Rscript run_SPARK.R --input=$2 --output=$3
elif [ "$1" = "SPARK-X" ]; then
    time Rscript run_SPARK-X.R --input=$2 --output=$3
elif [ "$1" = "nnSVG" ]; then
    time Rscript run_nnSVG.R --input=$2 --output=$3
else
    time python run_$1.py --input=$2 --output=$3
fi
echo "It took $(($(date +'%s') - $start)) seconds"
