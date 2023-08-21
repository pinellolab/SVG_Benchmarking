rule run_Spanve:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/Spanve/{dataset}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/Spanve/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_Spanve.py -i {input} -o {output}"