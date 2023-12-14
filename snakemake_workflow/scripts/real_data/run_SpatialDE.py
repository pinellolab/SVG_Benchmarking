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

    adata.obs['x'] = adata.obsm['spatial'][:, 0]
    adata.obs['y'] = adata.obsm['spatial'][:, 1]
    
    adata.obs['total_counts'] = adata.X.sum(axis=1)
    counts = adata.X.todense().astype(np.float32)
        
    counts = pd.DataFrame(data=counts, index=adata.obs_names, columns=adata.var_names)
    norm_expr = NaiveDE.stabilize(counts.T).T
    resid_expr = NaiveDE.regress_out(adata.obs, norm_expr.T, 'np.log(total_counts)').T
    X = adata.obs[['x', 'y']]
    df = SpatialDE.run(X, resid_expr)
    df.set_index("g", inplace=True)
    
    df = df.loc[~df.index.duplicated(keep='first')]
    
    df.to_csv(args.output)


if __name__ == "__main__":
    main()
