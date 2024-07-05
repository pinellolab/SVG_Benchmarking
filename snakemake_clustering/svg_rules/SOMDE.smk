rule SOMDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/data/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/output/svg/SOMDE/{dataset}.csv"
    conda:
        "zl_SOMDE"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/benchmark/svg/SOMDE/{dataset}.txt"
    shell:
        "python /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/05_snakemake_clustering/svg_methods/run_SOMDE.py -i {input} -o {output}"