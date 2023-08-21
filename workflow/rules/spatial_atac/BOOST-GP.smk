rule run_BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/BOOST-GP/{dataset}.csv"
    conda:
        "BOOST-GP"
    threads: 10
    benchmark:
        "benchmarks/real_data/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript scripts/real_data/run_BOOST-GP.R -i {input} -o {output}"