rule run_SpaGCN:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/SpaGCN/{dataset}.csv"
    conda:
        "SpaGCN"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/SpaGCN/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_SpaGCN.py -i {input} -o {output}"