rule run_nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/nnSVG/{dataset}.csv"
    conda:
        "nnSVG"
    threads: 10
    benchmark:
        "benchmarks/human_heart/nnSVG/{dataset}.txt"
    shell:
        "Rscript scripts/real_data/run_nnSVG.R -i {input} -o {output}"
