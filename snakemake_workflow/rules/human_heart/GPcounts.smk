rule run_GPcounts:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/GPcounts/{dataset}.csv"
    conda:
        "GPcounts-GPU"
    threads: 10
    benchmark:
        "benchmarks/human_heart/GPcounts/{dataset}.txt"
    shell:
        "python scripts/real_data/run_GPcounts.py -i {input} -o {output}"