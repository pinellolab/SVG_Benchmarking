rule run_GPcounts:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/GPcounts/{dataset}.csv"
    conda:
        "GPcounts-GPU"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/GPcounts/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_GPcounts.py -i {input} -o {output}"