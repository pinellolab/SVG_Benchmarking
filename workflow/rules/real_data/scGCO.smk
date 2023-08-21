rule run_scGCO:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/scGCO/{dataset}.csv"
    conda:
        "scGCO"
    threads: 10
    benchmark:
        "benchmarks/real_data/scGCO/{dataset}.txt"
    shell:
        "python scripts/real_data/run_scGCO.py -i {input} -o {output}"