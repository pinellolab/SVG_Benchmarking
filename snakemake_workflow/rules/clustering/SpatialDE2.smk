rule run_SpatialDE2:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/SpatialDE2/{dataset}.csv"
    conda:
        "SpatialDE2"
    threads: 10
    benchmark:
        "benchmarks/clustering/SpatialDE2/{dataset}.txt"
    shell:
        "python scripts/clustering/run_SpatialDE2.py -i {input} -o {output}"