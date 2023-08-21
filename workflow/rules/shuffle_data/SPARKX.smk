rule run_SPARKX:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/SPARK-X/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/SPARK-X/{dataset}.txt"
    shell:
        "Rscript scripts/shuffle_data/run_SPARK-X.R -i {input} -o {output}"