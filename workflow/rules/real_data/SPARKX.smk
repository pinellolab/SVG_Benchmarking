rule run_SPARKX:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/SPARK-X/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/real_data/SPARK-X/{dataset}.txt"
    shell:
        "Rscript scripts/real_data/run_SPARK-X.R -i {input} -o {output}"