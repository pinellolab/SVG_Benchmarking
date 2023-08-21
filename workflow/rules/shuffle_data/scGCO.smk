rule run_scGCO:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/scGCO/{dataset}.csv"
    conda:
        "scGCO"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/scGCO/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_scGCO.py -i {input} -o {output}"