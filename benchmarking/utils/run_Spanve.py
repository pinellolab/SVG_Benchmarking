"""Run Sepal"""

import numpy as np
import argparse
from Spanve import Spanve
from Spanve import adata_preprocess_int
import scanpy as sc


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

    return parser.parse_args()


def main():
    args = parse_args()

    adata = sc.read_h5ad(args.input)
    adata.X = adata.layers['counts'].todense().astype(int).copy()
    adata.X = np.asarray(adata.X)
    
    spanve = Spanve(adata)
    spanve.fit(verbose=True)
    df = spanve.result_df
    if "spatially_variable" in adata.var.columns:
        df = df.loc[adata.var_names]
        df['spatially_variable'] = adata.var.spatially_variable.astype(np.int16).values
        df = df[['fdrs', 'spatially_variable']]
        
    df.to_csv(args.output)


if __name__ == "__main__":
    main()
