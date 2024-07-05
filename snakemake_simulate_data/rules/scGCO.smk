rule scGCO:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/01_generate_simulate_data/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/02_snakemake_simulate_data/output/scGCO/{dataset}.csv"
    conda:
        "scGCO"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/02_snakemake_simulate_data/benchmark/scGCO/{dataset}.txt"
    shell:
        "python /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/02_snakemake_simulate_data/methods/run_scGCO.py -i {input} -o {output}"