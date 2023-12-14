rule run_SpatialDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/SpatialDE/{dataset}.csv"
    conda:
        "SpatialDE"
    threads: 10
    benchmark:
        "benchmarks/real_data/SpatialDE/{dataset}.txt"
    shell:
        "python scripts/real_data/run_SpatialDE.py -i {input} -o {output}"