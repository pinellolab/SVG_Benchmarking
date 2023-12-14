rule run_SpatialDE2:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/SpatialDE2/{dataset}.csv"
    conda:
        "SpatialDE2"
    threads: 10
    benchmark:
        "benchmarks/scalability/SpatialDE2/{dataset}.txt"
    shell:
        "python scripts/scalability/run_SpatialDE2.py -i {input} -o {output}"