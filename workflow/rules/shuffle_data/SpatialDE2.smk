rule run_SpatialDE2:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/SpatialDE2/{dataset}.csv"
    conda:
        "SpatialDE2"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/SpatialDE2/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_SpatialDE2.py -i {input} -o {output}"