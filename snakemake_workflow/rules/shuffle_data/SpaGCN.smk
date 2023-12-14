rule run_SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/SpaGCN/{dataset}.csv"
    conda:
        "SpaGCN"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/SpaGCN/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_SpaGCN.py -i {input} -o {output}"