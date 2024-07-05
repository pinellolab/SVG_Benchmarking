rule Leiden:
    input:
        data="/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/data/{dataset}.h5ad",
        genes="/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/02_get_genes/{svg_method}/{dataset}_{n_genes}.csv"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/output/clustering/Leiden/{svg_method}/{dataset}_{n_genes}.csv"
    conda:
        "zl_leiden"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/benchmark/clustering/Leiden/{svg_method}/{dataset}_{n_genes}.txt"
    shell:
        "python /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/05_snakemake_clustering/clustering_methods/run_Leiden.py --input_data {input.data} --input_genes {input.genes} -o {output}"
