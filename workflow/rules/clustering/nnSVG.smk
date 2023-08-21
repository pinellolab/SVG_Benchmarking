rule run_nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/nnSVG/{dataset}.csv"
    conda:
        "nnSVG"
    threads: 10
    benchmark:
        "benchmarks/clustering/nnSVG/{dataset}.txt"
    shell:
        "Rscript scripts/clustering/run_nnSVG.R -i {input} -o {output}"
