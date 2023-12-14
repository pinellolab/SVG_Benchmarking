rule run_BOOSTGP_v2:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/BOOST-GP-v2/{dataset}.csv"
    conda:
        "BOOST-GP"
    threads: 100
    benchmark:
        "benchmarks/real_data_shuffle/BOOST-GP-v2/{dataset}.txt"
    shell:
        "Rscript scripts/real_data_shuffle/run_BOOST-GP-v2.R -i {input} -o {output}"
