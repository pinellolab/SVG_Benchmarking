rule run_SpatialDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/SpatialDE/{dataset}.csv"
    conda:
        "SpatialDE"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/SpatialDE/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_SpatialDE.py -i {input} -o {output}"