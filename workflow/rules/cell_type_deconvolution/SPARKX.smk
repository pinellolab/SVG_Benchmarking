rule run_SPARKX:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/SPARK-X/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/SPARK-X/{dataset}.txt"
    shell:
        "Rscript scripts/cell_type_deconvolution/run_SPARK-X.R -i {input} -o {output}"