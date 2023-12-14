rule run_SPARK:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/SPARK/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/clustering/SPARK/{dataset}.txt"
    shell:
        "Rscript scripts/clustering/run_SPARK.R -i {input} -o {output}"