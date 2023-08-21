"""Run Sepal"""
import pandas as pd
import numpy as np
import argparse
import scanpy as sc
import squidpy as sq

def parse_args():
    parser = argparse.ArgumentParser(description="Run Sepal with command line")
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
    parser.add_argument(
        "-m", "--max_neighs", type=int, default=6, help="max_neighs"
    )

    return parser.parse_args()

def main():
    args = parse_args()

    adata = sc.read_h5ad(args.input)
    sq.gr.spatial_neighbors(adata, coord_type="grid", delaunay=False)
    sq.gr.sepal(adata, max_neighs=args.max_neighs, genes=adata.var_names, n_jobs=10)
    df = adata.uns["sepal_score"]
    
    df = df.loc[adata.var_names]
    df.to_csv(args.output)

if __name__ == "__main__":
    main()
