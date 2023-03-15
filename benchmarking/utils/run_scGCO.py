"""Run scGCO"""

import pandas as pd
import numpy as np
import argparse
import scanpy as sc
from scGCO import *

def parse_args():
    parser = argparse.ArgumentParser(description="Run scGCO with command line")
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

    data = pd.DataFrame(
        adata.X.todense(), columns=adata.var_names, index=adata.obs_names
    )
    exp = data.iloc[:, 0]
    locs = adata.obsm["spatial"].astype(np.int16)
    cellGraph = create_graph_with_weight(locs, exp)
    gmmDict = gmm_model(data)  # multiGMM
    df = identify_spatial_genes(locs, data, cellGraph, gmmDict)
    
    if "spatially_variable" in adata.var.columns:    
        df = df.loc[adata.var_names]
        df["spatially_variable"] = adata.var.spatially_variable.astype(np.int16).values
        df = df[["fdr", "spatially_variable"]]

    df.to_csv(args.output)


if __name__ == "__main__":
    main()
