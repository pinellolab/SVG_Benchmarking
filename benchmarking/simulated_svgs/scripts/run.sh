#!/usr/bin/bash

source ~/.bashrc
conda activate svg

start=$(date +'%s')

cd ../../utils

if [ "$1" = "BOOST-GP" ]; then
    time Rscript run_boost_gp.R --input=$2 --output=$3
elif [ "$1" = "SMODE" ]; then
    time python run_smode.py --input=$2 --output=$3
elif [ "$1" = "MoranI" ]; then
    time python run_MoranI.py --input=$2 --output=$3
elif [ "$1" = "scGCO" ]; then
    time python run_scGCO.py --input=$2 --output=$3
elif [ "$1" = "Sepal" ]; then
    time python run_Sepal.py --input=$2 --output=$3
else
    echo "Cannot find method"
fi
echo "It took $(($(date +'%s') - $start)) seconds"
