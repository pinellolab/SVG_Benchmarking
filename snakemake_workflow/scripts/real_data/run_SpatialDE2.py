"""Run SpatialDE2"""
import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"

import warnings
warnings.filterwarnings("ignore")

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

tqdm.__init__ = partialmethod(tqdm.__init__, disable=True)

def parse_args():
    parser = argparse.ArgumentParser(description="Run SpatialDE with command line")
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
    sc.pp.normalize_total(adata, target_sum=1e4)
    
    df = sd.fit(adata, normalized=True, control=None)
    df.set_index("gene", inplace=True)
    df.sort_values("FSV", inplace=True, ascending=False)
    
    df.to_csv(args.output)

if __name__ == "__main__":
    main()
