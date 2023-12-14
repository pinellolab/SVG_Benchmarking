rule run_Sepal:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/Sepal/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/Sepal/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_Sepal.py -i {input} -o {output}"