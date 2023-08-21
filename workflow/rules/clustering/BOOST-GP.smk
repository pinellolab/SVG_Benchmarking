rule run_BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/BOOST-GP/{dataset}.csv"
    conda:
        "BOOST-GP"
    threads: 100
    benchmark:
        "benchmarks/clustering/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript scripts/clustering/run_BOOST-GP.R -i {input} -o {output}"
