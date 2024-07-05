rule BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/01_generate_simulate_data/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/02_snakemake_simulate_data/output/BOOST-GP/{dataset}.csv"
    conda:
        "zl_BOOST-GP"
    threads: 100
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/02_snakemake_simulate_data/benchmark/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/02_snakemake_simulate_data/methods/run_BOOST-GP.R -i {input} -o {output}"