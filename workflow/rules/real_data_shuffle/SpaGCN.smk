rule run_SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/SpaGCN/{dataset}.csv"
    conda:
        "SpaGCN"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/SpaGCN/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_SpaGCN.py -i {input} -o {output}"