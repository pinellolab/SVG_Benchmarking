rule SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/01_generate_simulate_data/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/02_snakemake_simulate_data/output/SpaGCN/{dataset}.csv"
    conda:
        "zl_SpaGCN"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/02_snakemake_simulate_data/benchmark/SpaGCN/{dataset}.txt"
    shell:
        "python /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/02_snakemake_simulate_data/methods/run_SpaGCN.py -i {input} -o {output}"