"""Run MoranI"""

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
    
    sq.gr.spatial_neighbors(adata, 
                            coord_type="generic", 
                            delaunay=True)
    
    sq.gr.spatial_autocorr(adata, mode="moran", 
                           n_perms=100, n_jobs=10, 
                           genes=adata.var_names)
    
    # save results
    df_res = adata.uns["moranI"]
    df_res = df_res.loc[adata.var_names]
    
    df = pd.concat([df_res, adata.var], axis=1)
    df.to_csv(args.output)


if __name__ == "__main__":
    main()
