"""Run SpatialDE2"""
import warnings
warnings.filterwarnings("ignore")

import os
os.environ["OMP_NUM_THREADS"] = "10" # export OMP_NUM_THREADS=1
os.environ["OPENBLAS_NUM_THREADS"] = "10" # export OPENBLAS_NUM_THREADS=1
os.environ["MKL_NUM_THREADS"] = "10" # export MKL_NUM_THREADS=1
os.environ["VECLIB_MAXIMUM_THREADS"] = "10" # export VECLIB_MAXIMUM_THREADS=1
os.environ["NUMEXPR_NUM_THREADS"] = "10" # export NUMEXPR_NUM_THREADS=1
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"
os.environ["TF_CPP_MIN_LOG_LEVEL"] = '3'

import pandas as pd
import numpy as np
import argparse
import scanpy as sc
import pandas as pd
import numpy as np
import tracemalloc
import SpatialDE as sd
from tqdm import tqdm
from functools import partialmethod

import NaiveDE

tqdm.__init__ = partialmethod(tqdm.__init__, disable=True)

def parse_args():
    parser = argparse.ArgumentParser(description="Run SpatialDE2 with command line")
    parser.add_argument(
        "-i",
        "--input",
        type=str,
        default=None,
        help="Input filename, must be an Anndata object",
    )
    parser.add_argument(
        "-o", "--output", type=str, default=None, help="Output name"
    )

    return parser.parse_args()

def main():
    args = parse_args()

    adata = sc.read_h5ad(args.input)
    
    # normalization
    sc.pp.calculate_qc_metrics(adata, inplace=True, percent_top=[10])

    counts = sc.get.obs_df(adata, 
                           keys=list(adata.var_names), 
                           use_raw=False, layer='counts')

    total_counts = sc.get.obs_df(adata, keys=["total_counts"])
    norm_expr = NaiveDE.stabilize(counts.T).T
    adata.X = NaiveDE.regress_out(total_counts, norm_expr.T, "np.log(total_counts)").T
    
    # run SpatialDE2
    df_res = sd.fit(adata, normalized=True, control=None)
    df_res.set_index("gene", inplace=True)
    df_res = df_res.loc[adata.var_names]

    df_res.to_csv(args.output)

if __name__ == "__main__":
    main()
