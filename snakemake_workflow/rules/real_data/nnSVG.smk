rule run_nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSelected/{dataset}.h5ad"
    output:
        "results/real_data/nnSVG/{dataset}.csv"
    conda:
        "nnSVG"
    threads: 10
    benchmark:
        "benchmarks/real_data/nnSVG/{dataset}.txt"
    shell:
        "Rscript scripts/real_data/run_nnSVG.R -i {input} -o {output}"
