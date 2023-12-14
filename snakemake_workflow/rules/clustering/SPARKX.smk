rule run_SPARKX:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/SPARK-X/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/clustering/SPARK-X/{dataset}.txt"
    shell:
        "Rscript scripts/clustering/run_SPARK-X.R -i {input} -o {output}"