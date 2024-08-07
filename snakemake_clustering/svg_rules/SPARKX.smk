rule SPARKX:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/data/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/output/svg/SPARK-X/{dataset}.csv"
    conda:
        "zl_SPARKX"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/benchmark/svg/SPARKX/{dataset}.txt"
    shell:
        "Rscript /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/05_snakemake_clustering/svg_methods/run_SPARK-X.R -i {input} -o {output}"