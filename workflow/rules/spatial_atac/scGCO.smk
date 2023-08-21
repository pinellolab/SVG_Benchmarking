rule run_scGCO:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/scGCO/{dataset}.csv"
    conda:
        "scGCO"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/scGCO/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_scGCO.py -i {input} -o {output}"