rule run_SOMDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/SOMDE/{dataset}.csv"
    conda:
        "SOMDE"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/SOMDE/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_SOMDE.py -i {input} -o {output}"