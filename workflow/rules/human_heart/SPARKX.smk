rule run_SPARKX:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/SPARK-X/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/human_heart/SPARK-X/{dataset}.txt"
    shell:
        "Rscript scripts/real_data/run_SPARK-X.R -i {input} -o {output}"