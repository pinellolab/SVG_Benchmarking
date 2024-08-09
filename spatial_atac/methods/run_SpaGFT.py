"""Run SpaGFT"""

import pandas as pd
import numpy as np
import argparse
import scanpy as sc
import SpaGFT as spg

def parse_args():
    parser = argparse.ArgumentParser(description="Run SpaGFT with command line")
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
    
    adata.obs.loc[:, ['array_row', 'array_col']] = adata.obsm['spatial']
        
    (ratio_low, ratio_high) = spg.gft.determine_frequency_ratio(adata, ratio_neighbors=1)
        
    df = spg.detect_svg(adata,
                        spatial_info=['array_row', 'array_col'],
                        ratio_low_freq=ratio_low,
                        ratio_high_freq=ratio_high,
                        ratio_neighbors=1,
                        filter_peaks=True,
                        S=6)
    
    df = df.loc[adata.var_names]
    df.to_csv(args.output)


if __name__ == "__main__":
    main()
