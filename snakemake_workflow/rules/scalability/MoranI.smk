rule run_MoranI:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/MoranI/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/scalability/MoranI/{dataset}.txt"
    shell:
        "python scripts/scalability/run_MoranI.py -i {input} -o {output}"