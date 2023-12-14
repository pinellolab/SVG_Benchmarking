"""Run SpatialDE"""

import pandas as pd
import numpy as np
import argparse
import scanpy as sc
import pandas as pd
import numpy as np

import NaiveDE
import SpatialDE

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
        "-o", "--output", type=str, default=None, help="Output filename for results"
    )

    return parser.parse_args()


def main():
    args = parse_args()

    adata = sc.read_h5ad(args.input)

    counts = pd.DataFrame(adata.X.todense(), columns=adata.var_names, index=adata.obs_names)
    coord = pd.DataFrame(adata.obsm['spatial'], columns=['x_coord', 'y_coord'], index=adata.obs_names)
    df = SpatialDE.run(coord, counts)
    
    df.set_index("g", inplace=True)
    
    df = df.loc[~df.index.duplicated(keep='first')]
    df = df.loc[adata.var_names]

    df.to_csv(args.output)

if __name__ == "__main__":
    main()
