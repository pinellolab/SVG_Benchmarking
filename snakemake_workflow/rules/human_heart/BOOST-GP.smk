rule run_BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/BOOST-GP/{dataset}.csv"
    conda:
        "BOOST-GP"
    threads: 10
    benchmark:
        "benchmarks/human_heart/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript scripts/real_data/run_BOOST-GP.R -i {input} -o {output}"