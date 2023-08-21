rule run_SpatialDE2:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/SpatialDE2/{dataset}.csv"
    conda:
        "SpatialDE2"
    threads: 10
    benchmark:
        "benchmarks/real_data/SpatialDE2/{dataset}.txt"
    shell:
        "python scripts/real_data/run_SpatialDE2.py -i {input} -o {output}"