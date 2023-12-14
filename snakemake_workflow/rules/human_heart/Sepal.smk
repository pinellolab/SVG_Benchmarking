rule run_Sepal:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/Sepal/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/human_heart/Sepal/{dataset}.txt"
    shell:
        "python scripts/real_data/run_Sepal.py -i {input} -o {output}"