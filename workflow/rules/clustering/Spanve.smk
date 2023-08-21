rule run_Spanve:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/Spanve/{dataset}.csv"
    conda:
        "Spanve"
    threads: 1
    benchmark:
        "benchmarks/clustering/Spanve/{dataset}.txt"
    shell:
        "python scripts/clustering/run_Spanve.py -i {input} -o {output}"