rule run_SpaGFT:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/SpaGFT/{dataset}.csv"
    conda:
        "SpaGFT"
    threads: 10
    benchmark:
        "benchmarks/scalability/SpaGFT/{dataset}.txt"
    shell:
        "python scripts/scalability/run_SpaGFT.py -i {input} -o {output}"