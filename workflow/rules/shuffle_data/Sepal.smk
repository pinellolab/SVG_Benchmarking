rule run_Sepal:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataShuffle/{dataset}.h5ad"
    output:
        "results/shuffle_data/Sepal/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/shuffle_data/Sepal/{dataset}.txt"
    shell:
        "python scripts/shuffle_data/run_Sepal.py -i {input} -o {output}"