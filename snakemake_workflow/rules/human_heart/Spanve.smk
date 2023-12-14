rule run_Spanve:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/Spanve/{dataset}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/human_heart/Spanve/{dataset}.txt"
    shell:
        "python scripts/real_data/run_Spanve.py -i {input} -o {output}"