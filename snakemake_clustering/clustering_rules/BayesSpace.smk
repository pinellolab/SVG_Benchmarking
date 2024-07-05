rule BayesSpace:
    input:
        data="/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/data/{dataset}.h5ad",
        genes="/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/02_get_genes/{svg_method}/{dataset}_{n_genes}.csv"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/output/clustering/BayesSpace/{svg_method}/{dataset}_{n_genes}.csv"
    conda:
        "zl_BayesSpace"
    threads: 5
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/05_snakemake_clustering/benchmark/clustering/BayesSpace/{svg_method}/{dataset}_{n_genes}.txt"
    shell:
        "Rscript /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/05_snakemake_clustering/clustering_methods/run_BayesSpace.R --input_data {input.data} --input_genes {input.genes} -o {output}"
