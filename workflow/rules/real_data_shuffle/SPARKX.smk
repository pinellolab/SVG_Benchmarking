rule run_SPARKX:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/SPARK-X/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/SPARK-X/{dataset}.txt"
    shell:
        "Rscript scripts/real_data_shuffle/run_SPARK-X.R -i {input} -o {output}"