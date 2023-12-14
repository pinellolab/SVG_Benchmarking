"""Run MoranI"""

import os
os.environ["OMP_NUM_THREADS"] = "10" # export OMP_NUM_THREADS=1
os.environ["OPENBLAS_NUM_THREADS"] = "10" # export OPENBLAS_NUM_THREADS=1
os.environ["MKL_NUM_THREADS"] = "10" # export MKL_NUM_THREADS=1
os.environ["VECLIB_MAXIMUM_THREADS"] = "10" # export VECLIB_MAXIMUM_THREADS=1
os.environ["NUMEXPR_NUM_THREADS"] = "10" # export NUMEXPR_NUM_THREADS=1

import pandas as pd
import numpy as np
import argparse
import scanpy as sc
import squidpy as sq


def parse_args():
    parser = argparse.ArgumentParser(description="Run MoranI with command line")
    parser.add_argument(
        "-i",
        "--input",
        type=str,
        default=None,
        help="Input filename, must be an Anndata object",
    )
    parser.add_argument(
        "-o", "--output", type=str, default=None, help="Output filename for results"
    )

    return parser.parse_args()


def main():
    args = parse_args()

    adata = sc.read_h5ad(args.input)
    sc.pp.normalize_total(adata)
    sc.pp.log1p(adata)
    
    sq.gr.spatial_neighbors(adata)
    sq.gr.spatial_autocorr(adata, mode="moran", n_perms=100, n_jobs=10, genes=adata.var_names)
    df = adata.uns["moranI"]
    df.to_csv(args.output)


if __name__ == "__main__":
    main()
