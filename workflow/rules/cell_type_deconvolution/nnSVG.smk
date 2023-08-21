rule run_nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/nnSVG/{dataset}.csv"
    conda:
        "nnSVG"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/nnSVG/{dataset}.txt"
    shell:
        "Rscript scripts/cell_type_deconvolution/run_nnSVG.R -i {input} -o {output}"
