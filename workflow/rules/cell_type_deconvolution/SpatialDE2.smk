rule run_SpatialDE2:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/SpatialDE2/{dataset}.csv"
    conda:
        "SpatialDE2"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/SpatialDE2/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_SpatialDE2.py -i {input} -o {output}"