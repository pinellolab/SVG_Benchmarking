rule run_SpaGFT:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/SpaGFT/{dataset}.csv"
    conda:
        "SpaGFT"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/SpaGFT/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_SpaGFT.py -i {input} -o {output}"