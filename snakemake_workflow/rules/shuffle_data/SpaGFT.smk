rule run_SpaGFT:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/SpaGFT/{dataset}.csv"
    conda:
        "SpaGFT"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/SpaGFT/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_SpaGFT.py -i {input} -o {output}"