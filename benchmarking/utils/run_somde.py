"""Run SOMDE"""

import pandas as pd
import argparse
import scanpy as sc
from somde import SomNode

def parse_args():
    parser = argparse.ArgumentParser(description='Run SOMDE with command line')
    parser.add_argument("-i", "--input", type=str, default=None,
                        help="Input filename, must be an Anndata object")
    parser.add_argument("-o", "--output", type=str, default=None,
                        help="Output filename for results")
    
    return parser.parse_args()

def main():
    args = parse_args()

    assert args.input is not None, "Please specify an input"
    assert args.output is not None, "Please specify an output filename"
    print(args)

    adata = sc.read_h5ad(args.input)

    data = pd.DataFrame(adata.layers['counts'].todense(), 
                        columns=adata.var_names, 
                        index=adata.obs_names)
    
    som = SomNode(adata.obsm['spatial'], k=20)

    # integrate data sites and expression
    ndf, ninfo = som.mtx(data.transpose())
    nres = som.norm()

    result, SVnum = som.run()
    result.index = adata.var_names[result.index.values]
    result.to_csv(args.output)

if __name__ == "__main__":
    main()