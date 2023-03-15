"""Submit jobs to cluster"""

import os
import subprocess

INPUT_DIR = "/data/scATA/SingleCellOpenChromatin/local/ongoing/SVG_Benchmarking/data/simulation/diverse_spatial_patterns"
OUTPUT_DIR = "/data/scATA/SingleCellOpenChromatin/local/ongoing/SVG_Benchmarking/benchmarking/diverse_spatial_patterns"

method_list = ["BOOST-GP", "SOMDE", "MoranI", 
               "scGCO", "Sepal", "SpaGCN", 
               "Spanve", "SPARK", "SPARK-X",
               "SpatialDE", "nnSVG"]

for method in method_list:
    if not os.path.exists(f"{OUTPUT_DIR}/{method}"):
        os.mkdir(f"{OUTPUT_DIR}/{method}")

    for i in range(10):
        input_anndata = f"{INPUT_DIR}/rep_{i}.h5ad"
        output_csv = f"{OUTPUT_DIR}/{method}/rep_{i}.csv"

        job_name = f"{method}_rep_{i}"
        subprocess.run(["sbatch", 
                        "-J", job_name,
                        "-o", f"./cluster_out/{job_name}.txt",
                        "-e", f"./cluster_err/{job_name}.txt",
                        "--time", "120:00:00",
                        "--mem", "100G",
                        "run.sh", method, input_anndata, output_csv],
                        check=True)
