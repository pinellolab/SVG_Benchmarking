rule run_SPARK:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/SPARK/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/SPARK/{dataset}.txt"
    shell:
        "Rscript scripts/shuffle_data/run_SPARK.R -i {input} -o {output}"