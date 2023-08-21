rule run_BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/BOOST-GP/{dataset}.csv"
    conda:
        "BOOST-GP"
    threads: 200
    benchmark:
        "benchmarks/real_data_shuffle/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript scripts/real_data_shuffle/run_BOOST-GP.R -i {input} -o {output}"
