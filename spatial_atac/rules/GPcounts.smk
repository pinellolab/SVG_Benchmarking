rule run_GPcounts:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/GPcounts/{dataset}.csv"
    conda:
        "GPcounts-GPU"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/GPcounts/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_GPcounts.py -i {input} -o {output}"