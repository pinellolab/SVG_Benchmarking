"""Run Spanve"""
import warnings
warnings.filterwarnings("ignore")

import os
import pandas as pd
import numpy as np
import argparse
import scanpy as sc
import pandas as pd
import numpy as np
from tqdm import tqdm
from functools import partialmethod
from Spanve import Spanve
from Spanve import adata_preprocess_int
import scanpy as sc

tqdm.__init__ = partialmethod(tqdm.__init__, disable=True)

def parse_args():
    parser = argparse.ArgumentParser(description="Run Spanve with command line")
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
    
    ##################################################
    # run method
    # http://htmlpreview.github.io/?https://github.com/gx-Cai/Spanve/blob/main/tutorial.html
    adata.X = adata.X.toarray()
    spanve = Spanve(adata)
    spanve.fit(verbose=False)
    df = spanve.result_df
    
    df = df.loc[adata.var_names]
    df.to_csv(args.output)

if __name__ == "__main__":
    main()
