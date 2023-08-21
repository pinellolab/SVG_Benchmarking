rule run_SOMDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/SOMDE/{dataset}.csv"
    conda:
        "SOMDE"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/SOMDE/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_SOMDE.py -i {input} -o {output}"