"""Run SpatialDE"""
import warnings
warnings.filterwarnings("ignore")

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
    sc.pp.calculate_qc_metrics(adata, inplace=True, percent_top=[10])
    
    counts = sc.get.obs_df(adata, 
                           keys=list(adata.var_names), 
                           use_raw=False, layer='counts')
    
    total_counts = sc.get.obs_df(adata, keys=["total_counts"])
    norm_expr = NaiveDE.stabilize(counts.T).T
    resid_expr = NaiveDE.regress_out(total_counts, 
                                     norm_expr.T, "np.log(total_counts)").T
    
    df_res = SpatialDE.run(adata.obsm["spatial"], resid_expr)
    df_res.set_index("g", inplace=True)
    df_res = df_res.loc[adata.var_names]
    
    df_res.to_csv(args.output)


if __name__ == "__main__":
    main()
