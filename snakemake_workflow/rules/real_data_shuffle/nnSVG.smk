rule run_nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/nnSVG/{dataset}.csv"
    conda:
        "nnSVG"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/nnSVG/{dataset}.txt"
    shell:
        "Rscript scripts/real_data_shuffle/run_nnSVG.R -i {input} -o {output}"
