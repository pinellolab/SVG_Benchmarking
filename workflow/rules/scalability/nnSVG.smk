rule run_nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Scalability/{dataset}.h5ad"
    output:
        "results/scalability/nnSVG/{dataset}.csv"
    conda:
        "nnSVG"
    threads: 10
    benchmark:
        "benchmarks/scalability/nnSVG/{dataset}.txt"
    shell:
        "Rscript scripts/scalability/run_nnSVG.R -i {input} -o {output}"
