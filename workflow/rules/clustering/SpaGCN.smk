rule run_SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/SpaGCN/{dataset}.csv"
    conda:
        "SpaGCN"
    threads: 10
    benchmark:
        "benchmarks/clustering/SpaGCN/{dataset}.txt"
    shell:
        "python scripts/clustering/run_SpaGCN.py -i {input} -o {output}"