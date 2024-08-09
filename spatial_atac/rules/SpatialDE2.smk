rule run_SpatialDE2:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/SpatialDE2/{dataset}.csv"
    conda:
        "SpatialDE2"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/SpatialDE2/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_SpatialDE2.py -i {input} -o {output}"