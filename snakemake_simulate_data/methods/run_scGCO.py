"""Run scGCO"""

import sys
sys.path.append("/data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/utils")

import os
import pandas as pd
import numpy as np
import argparse
import scanpy as sc
from scGCO_simple import *

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
       adata.layers['counts'].todense(), columns=adata.var_names, index=adata.obs_names
    )
    data_norm = normalize_count_cellranger(data)
    
    exp = data.iloc[:, 0]
    locs = adata.obsm['spatial'].copy()
    cellGraph = create_graph_with_weight(locs, exp)
    gmmDict= gmm_model(data_norm)
    
    df_res = identify_spatial_genes(locs, data_norm, cellGraph,gmmDict)
    df_res = df_res.loc[adata.var_names]
    
    df = pd.concat([df_res, adata.var], axis=1)
    df.to_csv(args.output)


if __name__ == "__main__":
    main()
