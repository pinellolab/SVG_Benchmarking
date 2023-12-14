"""Run SpaGCN"""

import argparse
import SpaGCN as spg
import os, csv, re
import pandas as pd
import numpy as np
import scanpy as sc
import math
from scipy.sparse import issparse
import random, torch
import warnings

warnings.filterwarnings("ignore")
import matplotlib.colors as clr
import matplotlib.pyplot as plt


def parse_args():
    parser = argparse.ArgumentParser(description="Run SpaGCN with command line")
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

    p = 0.5
    r_seed = t_seed = n_seed = 100
    min_in_group_fraction = 0
    min_in_out_group_ratio = 0
    min_fold_change = 0

    n_clusters = 5
    
    adata = sc.read_h5ad(args.input)
    sc.pp.normalize_total(adata)
    sc.pp.log1p(adata)
    
    adj = spg.calculate_adj_matrix(
        x=adata.obsm["spatial"][:, 0], y=adata.obsm["spatial"][:, 1], histology=False
    )
    l = spg.search_l(p, adj, start=0.01, end=1000, tol=0.01, max_run=100)

    res = spg.search_res(
        adata,
        adj,
        l,
        n_clusters,
        start=0.7,
        step=0.1,
        tol=5e-3,
        lr=0.05,
        max_epochs=20,
        r_seed=r_seed,
        t_seed=t_seed,
        n_seed=n_seed,
    )

    clf = spg.SpaGCN()
    clf.set_l(l)
    # Set seed
    random.seed(r_seed)
    torch.manual_seed(t_seed)
    np.random.seed(n_seed)
    
    # Run
    clf.train(
        adata,
        adj,
        init_spa=True,
        init="louvain",
        res=res,
        tol=5e-3,
        lr=0.05,
        max_epochs=200,
    )
    
    y_pred, prob = clf.predict()
    adata.obs["pred"] = y_pred

    de_genes_all = list()
    
    n_clusters = len(adata.obs["pred"].unique())
    
    print(n_clusters)
    
    for target in range(n_clusters):
        print(f"target: {target}")
        start, end = np.quantile(adj[adj != 0], q=0.001), np.quantile(
            adj[adj != 0], q=0.1
        )
        r = spg.search_radius(
            target_cluster=target,
            cell_id=adata.obs.index.tolist(),
            x=adata.obsm["spatial"][:, 0],
            y=adata.obsm["spatial"][:, 1],
            pred=adata.obs["pred"].tolist(),
            start=start,
            end=end,
            num_min=10,
            num_max=14,
            max_run=100,
        )

        try:
            nbr_domians = spg.find_neighbor_clusters(
                target_cluster=target,
                cell_id=adata.obs.index.tolist(),
                x=adata.obsm["spatial"][:, 0],
                y=adata.obsm["spatial"][:, 1],
                pred=adata.obs["pred"].tolist(),
                radius=r,
                ratio=0,
            )

            de_genes_info = spg.rank_genes_groups(
                input_adata=adata,
                target_cluster=target,
                nbr_list=nbr_domians,
                label_col="pred",
                adj_nbr=True,
                log=True,
            )
            de_genes_all.append(de_genes_info)
        except (RuntimeError, TypeError, NameError):
            pass

    df = pd.concat(de_genes_all)
    df = df.groupby(["genes"]).min()
    df.to_csv(args.output)


if __name__ == "__main__":
    main()
