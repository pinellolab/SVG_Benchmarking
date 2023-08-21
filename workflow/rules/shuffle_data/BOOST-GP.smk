rule run_BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/BOOST-GP/{dataset}.csv"
    conda:
        "BOOST-GP"
    threads: 50
    benchmark:
        "benchmarks/shuffle_data/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript scripts/shuffle_data/run_BOOST-GP.R -i {input} -o {output}"