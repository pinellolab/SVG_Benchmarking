"""Run Sepal"""

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
        "-o", "--output", type=str, default=None, help="Output filename for results"
    )
    parser.add_argument(
        "-m", "--max_neighs", type=int, default=4, help="max_neighs"
    )

    return parser.parse_args()


def main():
    args = parse_args()

    adata = sc.read_h5ad(args.input)
    sq.gr.spatial_neighbors(adata, coord_type="grid")
    sq.gr.sepal(adata, max_neighs=args.max_neighs, genes=adata.var_names, n_jobs=1)
    df = adata.uns["sepal_score"]
    if "spatially_variable" in adata.var.columns:
        df = df.loc[adata.var_names]
        df['spatially_variable'] = adata.var.spatially_variable.astype(np.int16).values
        df = df[['sepal_score', 'spatially_variable']]

    df.to_csv(args.output)


if __name__ == "__main__":
    main()