rule run_SOMDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/SOMDE/{dataset}.csv"
    conda:
        "SOMDE"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/SOMDE/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_SOMDE.py -i {input} -o {output}"