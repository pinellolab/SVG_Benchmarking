rule run_SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/SpaGCN/{dataset}.csv"
    conda:
        "SpaGCN"
    threads: 10
    benchmark:
        "benchmarks/human_heart/SpaGCN/{dataset}.txt"
    shell:
        "python scripts/real_data/run_SpaGCN.py -i {input} -o {output}"