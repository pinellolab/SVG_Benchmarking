rule run_MoranI:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/MoranI/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/MoranI/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_MoranI.py -i {input} -o {output}"