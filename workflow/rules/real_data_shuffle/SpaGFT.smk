rule run_SpaGFT:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/SpaGFT/{dataset}.csv"
    conda:
        "SpaGFT"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/SpaGFT/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_SpaGFT.py -i {input} -o {output}"