rule nnSVG:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/data/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/output/svg/nnSVG/{dataset}.csv"
    conda:
        "zl_nnSVG"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/benchmark/svg/nnSVG/{dataset}.txt"
    shell:
        "Rscript /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/05_snakemake_clustering/svg_methods/run_nnSVG.R -i {input} -o {output}"