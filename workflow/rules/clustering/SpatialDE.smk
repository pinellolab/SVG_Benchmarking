rule run_SpatialDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/SpatialDE/{dataset}.csv"
    conda:
        "SpatialDE"
    threads: 10
    benchmark:
        "benchmarks/clustering/SpatialDE/{dataset}.txt"
    shell:
        "python scripts/clustering/run_SpatialDE.py -i {input} -o {output}"