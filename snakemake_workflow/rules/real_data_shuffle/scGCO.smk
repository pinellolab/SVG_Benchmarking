rule run_scGCO:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/scGCO/{dataset}.csv"
    conda:
        "scGCO"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/scGCO/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_scGCO.py -i {input} -o {output}"