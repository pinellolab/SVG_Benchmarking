rule run_SPARK:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/SPARK/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/real_data/SPARK/{dataset}.txt"
    shell:
        "Rscript scripts/real_data/run_SPARK.R -i {input} -o {output}"