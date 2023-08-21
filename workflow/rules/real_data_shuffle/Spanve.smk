rule run_Spanve:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/Spanve/{dataset}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/Spanve/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_Spanve.py -i {input} -o {output}"