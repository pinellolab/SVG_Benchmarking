rule run_nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/nnSVG/{dataset}.csv"
    conda:
        "nnSVG"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/nnSVG/{dataset}.txt"
    shell:
        "Rscript scripts/shuffle_data/run_nnSVG.R -i {input} -o {output}"
