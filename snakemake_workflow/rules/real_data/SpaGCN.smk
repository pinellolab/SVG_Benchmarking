rule run_SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/SpaGCN/{dataset}.csv"
    conda:
        "SpaGCN"
    threads: 10
    benchmark:
        "benchmarks/real_data/SpaGCN/{dataset}.txt"
    shell:
        "python scripts/real_data/run_SpaGCN.py -i {input} -o {output}"