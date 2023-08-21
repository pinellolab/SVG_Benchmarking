rule run_GPcounts:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/GPcounts/{dataset}.csv"
    conda:
        "GPcounts-GPU"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/GPcounts/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_GPcounts.py -i {input} -o {output}"