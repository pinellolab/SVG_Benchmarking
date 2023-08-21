rule run_MoranI:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/MoranI/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/MoranI/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_MoranI.py -i {input} -o {output}"