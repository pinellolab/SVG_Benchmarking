rule BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/data/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/output/svg/BOOST-GP/{dataset}.csv"
    conda:
        "zl_BOOST-GP"
    threads: 100
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/benchmark/svg/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/05_snakemake_clustering/svg_methods/run_BOOST-GP.R -i {input} -o {output}"