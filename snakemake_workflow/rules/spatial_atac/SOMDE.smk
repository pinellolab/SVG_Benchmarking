rule run_SOMDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/SOMDE/{dataset}.csv"
    conda:
        "SOMDE"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/SOMDE/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_SOMDE.py -i {input} -o {output}"