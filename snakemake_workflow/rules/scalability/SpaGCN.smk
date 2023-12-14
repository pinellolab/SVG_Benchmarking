rule run_SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/SpaGCN/{dataset}.csv"
    conda:
        "SpaGCN"
    threads: 10
    benchmark:
        "benchmarks/scalability/SpaGCN/{dataset}.txt"
    shell:
        "python scripts/scalability/run_SpaGCN.py -i {input} -o {output}"