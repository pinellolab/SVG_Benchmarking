rule run_SPARKX:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/SPARK-X/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/scalability/SPARK-X/{dataset}.txt"
    shell:
        "Rscript scripts/scalability/run_SPARK-X.R -i {input} -o {output}"