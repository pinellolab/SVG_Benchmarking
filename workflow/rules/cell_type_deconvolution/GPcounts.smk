rule run_GPcounts:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/GPcounts/{dataset}.csv"
    conda:
        "GPcounts-GPU"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/GPcounts/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_GPcounts.py -i {input} -o {output}"