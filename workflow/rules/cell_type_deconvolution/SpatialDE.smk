rule run_SpatialDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/SpatialDE/{dataset}.csv"
    conda:
        "SpatialDE"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/SpatialDE/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_SpatialDE.py -i {input} -o {output}"