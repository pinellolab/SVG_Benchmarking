import subprocess

INPUT_DIR = "/data/scATA/SingleCellOpenChromatin/local/ongoing/SVG_Benchmarking/data/simulation/simulated"
OUTPUT_DIR = "/data/scATA/SingleCellOpenChromatin/local/ongoing/SVG_Benchmarking/benchmarking/BOOST-GP/svgs"

for i in range(10):
    input_anndata = f"{INPUT_DIR}/svgs_rep_{i}.h5ad"
    output_csv = f"{OUTPUT_DIR}/svgs_rep_{i}.csv"

    job_name = f"svgs_rep_{i}"
    subprocess.run(["sbatch", "-J", job_name,
                    "-o", f"./cluster_out/{job_name}.txt",
                    "-e", f"./cluster_err/{job_name}.txt",
                    "--time", "120:00:00",
                    "--mem", "180G",
                    "run.sh", input_anndata, output_csv])
