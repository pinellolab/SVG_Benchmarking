rule run_SOMDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/SOMDE/{dataset}.csv"
    conda:
        "SOMDE"
    threads: 10
    benchmark:
        "benchmarks/scalability/SOMDE/{dataset}.txt"
    shell:
        "python scripts/scalability/run_SOMDE.py -i {input} -o {output}"