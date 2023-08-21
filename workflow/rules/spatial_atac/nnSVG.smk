rule run_nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SpatialATAC/ProcessedData/AnnData/Enric_NBT_2023/{dataset}.h5ad"
    output:
        "results/spatial_atac/nnSVG/{dataset}.csv"
    conda:
        "nnSVG"
    threads: 10
    benchmark:
        "benchmarks/spatial_atac/nnSVG/{dataset}.txt"
    shell:
        "Rscript scripts/spatial_atac/run_nnSVG.R -i {input} -o {output}"
