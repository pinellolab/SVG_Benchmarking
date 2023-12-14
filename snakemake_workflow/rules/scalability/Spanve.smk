rule run_Spanve:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/Spanve/{dataset}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/scalability/Spanve/{dataset}.txt"
    shell:
        "python scripts/scalability/run_Spanve.py -i {input} -o {output}"