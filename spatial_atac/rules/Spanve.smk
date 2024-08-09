rule run_Spanve:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/Spanve/{dataset}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/Spanve/{dataset}.txt"
    shell:
        "python scripts/spatial_atac/run_Spanve.py -i {input} -o {output}"