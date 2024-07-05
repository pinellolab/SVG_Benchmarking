rule SpatialDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/01_generate_simulate_data/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/02_snakemake_simulate_data/output/SpatialDE/{dataset}.csv"
    conda:
        "zl_spatialDE"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/02_snakemake_simulate_data/benchmark/SpatialDE/{dataset}.txt"
    shell:
        "python /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/02_snakemake_simulate_data/methods/run_SpatialDE.py -i {input} -o {output}"