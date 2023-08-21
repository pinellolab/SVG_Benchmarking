rule run_Spanve:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/Spanve/{dataset}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/real_data/Spanve/{dataset}.txt"
    shell:
        "python scripts/real_data/run_Spanve.py -i {input} -o {output}"