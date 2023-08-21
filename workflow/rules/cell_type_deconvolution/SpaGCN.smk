rule run_SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/SpaGCN/{dataset}.csv"
    conda:
        "SpaGCN"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/SpaGCN/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_SpaGCN.py -i {input} -o {output}"