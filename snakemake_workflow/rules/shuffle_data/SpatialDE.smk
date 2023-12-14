rule run_SpatialDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/SpatialDE/{dataset}.csv"
    conda:
        "SpatialDE"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/SpatialDE/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_SpatialDE.py -i {input} -o {output}"