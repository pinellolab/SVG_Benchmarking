rule run_BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/BOOST-GP/{dataset}.csv"
    conda:
        "BOOST-GP"
    threads: 10
    benchmark:
        "benchmarks/scalability/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript scripts/scalability/run_BOOST-GP.R -i {input} -o {output}"