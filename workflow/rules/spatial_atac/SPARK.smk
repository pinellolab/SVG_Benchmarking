rule run_SPARK:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/SPARK/{dataset}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/SPARK/{dataset}.txt"
    shell:
        "Rscript scripts/spatial_atac/run_SPARK.R -i {input} -o {output}"