"""Run SOMDE"""

import argparse
import pandas as pd
import numpy as np
import scanpy as sc
from somde import SomNode


def parse_args():
    parser = argparse.ArgumentParser(description="Run SOMDE with command line")
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
        adata.layers["counts"].todense(), columns=adata.var_names, index=adata.obs_names
    )

    X = pd.DataFrame(adata.obsm["spatial"], index=adata.obs_names, columns=["x", "y"])
    som = SomNode(adata.obsm["spatial"], k=10)
    ndf, ninfo = som.mtx(data.transpose())
    nres = som.norm()
    df, SVnum = som.run()
    df.set_index("g", inplace=True)
    
    df = df.loc[adata.var_names]
    df.to_csv(args.output)


if __name__ == "__main__":
    main()
