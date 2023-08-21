rule run_SPARK:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/SPARK/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/scalability/SPARK/{dataset}.txt"
    shell:
        "Rscript scripts/scalability/run_SPARK.R -i {input} -o {output}"