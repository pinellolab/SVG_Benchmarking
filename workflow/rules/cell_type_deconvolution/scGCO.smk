rule run_scGCO:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/scGCO/{dataset}.csv"
    conda:
        "scGCO"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/scGCO/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_scGCO.py -i {input} -o {output}"