rule run_scGCO:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/scGCO/{dataset}.csv"
    conda:
        "scGCO"
    threads: 10
    benchmark:
        "benchmarks/human_heart/scGCO/{dataset}.txt"
    shell:
        "python scripts/real_data/run_scGCO.py -i {input} -o {output}"