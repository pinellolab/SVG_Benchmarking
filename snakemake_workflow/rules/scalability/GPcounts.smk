rule run_GPcounts:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/GPcounts/{dataset}.csv"
    conda:
        "GPcounts-GPU"
    threads: 10
    benchmark:
        "benchmarks/scalability/GPcounts/{dataset}.txt"
    shell:
        "python scripts/scalability/run_GPcounts.py -i {input} -o {output}"