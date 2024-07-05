"""Run K-means"""

import pandas as pd
import numpy as np
import argparse
import scanpy as sc
import squidpy as sq

import warnings
warnings.filterwarnings("ignore")
from sklearn.cluster import KMeans

def parse_args():
    parser = argparse.ArgumentParser(description="Run Leiden clustering with command line")
    parser.add_argument("--input_data", type=str, default=None)
    parser.add_argument("--input_genes", type=str, default=None)
    parser.add_argument(
        "-o", "--output", type=str, default=None, help="Output filename for results"
    )
    return parser.parse_args()


def main():
    args = parse_args()

    adata = sc.read_h5ad(args.input_data)
    df = pd.read_csv(args.input_genes)
    
    # subset genes
    adata = adata[:, df['gene'].values.tolist()]
    
    sc.tl.pca(adata, n_comps=30)
   
    # run K-means
    n_clusters = len(adata.obs['spatialLIBD'].unique())
    kmeans = KMeans(n_clusters=n_clusters, random_state=0, n_init="auto").fit(adata.obsm['X_pca'])
    adata.obs['clusters'] = kmeans.labels_
    adata.obs['clusters'] = adata.obs['clusters'].astype(str)
    
    df = adata.obs[['spatialLIBD', 'clusters']]
    df.to_csv(args.output)

if __name__ == "__main__":
    main()
